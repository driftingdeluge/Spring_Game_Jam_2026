extends CharacterBody2D
class_name GroundEnemy

@export var gravity := 1000
@export var speed := -100
@export var jump_force := -300

func disable_movement():
	var temp_speed = speed
	speed = 0
	await get_tree().create_timer(1.0, false, true, false).timeout
	speed = temp_speed

func _physics_process(delta):
	velocity.x = -speed
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision:
			var angle = collision.get_angle()
			if collision.get_collider().is_class("CharacterBody2D"):
				if not ((angle >= PI*.75 and angle <= PI*1.25) or (angle <= PI*.25 or angle >= PI*1.75)):
					speed = -speed
				elif (angle >= PI*.75 and angle <= PI*1.25) and speed != 0: #this needs to go in the player
					disable_movement()
		
	if not is_on_floor():
		velocity.y += gravity * delta
	elif speed != 0:
		velocity.y = jump_force

func die():
	queue_free()
