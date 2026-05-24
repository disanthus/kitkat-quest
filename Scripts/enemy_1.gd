extends CharacterBody2D

@onready var player = get_node("res://Scenes/player.tscn")
const SPEED = 200.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if player:
		var playerlocation = position.direction_to(player.position)
		velocity = playerlocation * SPEED
		move_and_slide()

	move_and_slide()
