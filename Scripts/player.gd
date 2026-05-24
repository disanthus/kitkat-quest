extends CharacterBody2D

var treasure = 0
@onready var treasure_label = %CounterLabel
func _ready() -> void:
	add_to_group("player")
const SPEED = 300.0
const JUMP_VELOCITY = -500.0

func _physics_process(delta: float) -> void:
# MOVEMENT
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")

	if direction:
		if direction == -1:
			$Sprite2D.flip_h = true
		else:
			$Sprite2D.flip_h = false
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
# INVENTORY
# sets treasure count
func _set_treasure(new_treasure_count: int) -> void:
		treasure = new_treasure_count
		treasure_label.text = "TREASURE: " + str(treasure)

# updates treasure count
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("treasure"):
		_set_treasure(treasure + 1)
		print(treasure)

# ME WANT MEOW FUNCTION
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("meow"):
		%Meow.visible = true
		%Meow.text = (["Meow", "Mao", "Rao", "Nya", "Mrrrp!"]).pick_random()
	
	if Input.is_action_just_released("meow"):
		%Meow.visible = false
