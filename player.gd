extends CharacterBody2D

@export var speed := 100
@export var jump_force := -600
@export var gravity := 1000
@export var rotation_speed = 3.0
@export var mode = 0 #0 for jump, 1 for switch direction, 2 for attack

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	velocity.x = speed
	
	if Input.is_action_just_pressed("changeMode"):
		mode += 1
		if mode > 2:
			mode = 0

	if Input.is_action_just_pressed("jump") and is_on_floor():
		match mode:
			0:
				velocity = Vector2.UP.rotated(rotation) * rotation_speed
				velocity.y = jump_force
				AudioManager.playSound("jump.wav", 0)
			1:
				speed = -speed
			2:
				mode = 2 # attack goes here once enemies are created

	move_and_slide()
