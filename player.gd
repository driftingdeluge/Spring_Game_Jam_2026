extends CharacterBody2D

@export var speed := 100
@export var jump_force := -600
@export var gravity := 1000
@export var rotation_speed = 3.0

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	velocity.x = speed

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity = Vector2.UP.rotated(rotation) * rotation_speed
		velocity.y = jump_force
		AudioManager.playSound("jump.wav", 0)

	move_and_slide()
