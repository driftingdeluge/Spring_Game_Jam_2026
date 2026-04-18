extends CharacterBody2D

@export var speed := 200
@export var jump_force := -400
@export var gravity := 1000

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Constant forward movement
	velocity.x = speed

	# Jump input
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force

	move_and_slide()
