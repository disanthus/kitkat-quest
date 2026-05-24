extends CharacterBody2D

const speed = 40
var current_state = IDLE
var direction = Vector2.RIGHT
var start_position
var is_roaming = true
var is_chatting = false
var player_in_range = false
var can_interact = true

enum {
	IDLE,
	NEW_DIR,
	MOVE
}

func _ready() -> void:
	randomize()
	start_position = position

func _physics_process(delta: float) -> void:
	# changes npc state to chatting
	if player_in_range and can_interact and Input.is_action_just_pressed("interact"):
		$ChatPrompt.visible = false
		is_roaming = false
		is_chatting = true
		can_interact = false
		$AnimatedSprite2D.play("idle")
		$Dialogue.visible = true
		$Dialogue.start()
	# changes npc state to roaming and resets dialogue
	elif !player_in_range:
		is_roaming = true
		is_chatting = false
		$ChatPrompt.visible = false
		$Dialogue.visible = false
		$Dialogue.stop()
	# checks if against the wall and bounces them off / flips sprite if true
	if is_on_wall():
		direction *= -1
		if direction == Vector2.LEFT:
			%AnimatedSprite2D.flip_h = true
		else:
			%AnimatedSprite2D.flip_h = false
	# roaming states
	if !is_chatting and is_roaming:
		match current_state:
			IDLE: 
				$AnimatedSprite2D.play("idle")
			NEW_DIR:
				$AnimatedSprite2D.play("idle")
				direction = ([Vector2.RIGHT, Vector2.LEFT]).pick_random()
				if direction == Vector2.LEFT:
					%AnimatedSprite2D.flip_h = true
				else:
					%AnimatedSprite2D.flip_h = false
				current_state = ([MOVE, IDLE]).pick_random()
			MOVE:
				$AnimatedSprite2D.play("move")
				move()
# npc movement
func move():
	if !is_chatting:
		velocity = direction * speed
		move_and_slide()
# timer
func _on_timer_timeout() -> void:
	$Timer.wait_time = ([1, 2, 3]).pick_random()
	current_state = ([IDLE, NEW_DIR, MOVE]).pick_random()
# player enters detection range
func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		$ChatPrompt.visible = true

# player leaves detection range 
func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		is_chatting = false
		is_roaming = true
# npc state returns to roaming at end of dialogue
func _on_dialogue_dialogue_finished() -> void:
	is_chatting = false
	is_roaming = true
	
	await get_tree().process_frame
	await get_tree().process_frame
	
	can_interact = true
