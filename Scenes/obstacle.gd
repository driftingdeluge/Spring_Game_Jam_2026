extends CharacterBody2D

@export var speed := 200

func _physics_process(delta):
	velocity.x = -speed
	move_and_slide()

	if global_position.x < -100:
		queue_free()
