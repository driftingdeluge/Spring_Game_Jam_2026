extends CharacterBody2D

@export var gravity := 1000
@export var speed := 200
@export var jump_force := -600


func _physics_process(delta):
	velocity.x = -speed
	# sup
	move_and_slide()
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_on_floor():
		velocity.y = jump_force

	if global_position.x < -100:
		queue_free()
