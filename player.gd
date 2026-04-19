extends CharacterBody2D

@export var speed := 150
@export var jump_force := -600
@export var gravity := 1000
@export var rotation_speed = 3.0
@export var mode = 0 #0 for jump, 1 for switch direction, 2 for attack

signal got_hit

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	velocity.x = speed
	
	if Input.is_action_just_pressed("changeMode"):
		mode += 1
		if mode > 2:
			mode = 0

	if Input.is_action_just_pressed("jump"):
		match mode:   
			0:
				var space_state = get_world_2d().direct_space_state
				# Create a ray from current position forward, keep default collision mask and excluse self
				var query = PhysicsRayQueryParameters2D.create(position, Vector2(position.x + (2 * speed), position.y), 0xFFFFFFFF, [self.get_rid()])
				var result = space_state.intersect_ray(query)
				# if attack hits something
				if result and result.collider is GroundEnemy:
					if abs(result.collider.speed) / -result.collider.speed == abs(speed) / speed:
						result.collider.die()
			1:
				if is_on_floor():
					velocity = Vector2.UP.rotated(rotation) * rotation_speed
					velocity.y = jump_force
					AudioManager.playSound("jump.wav", 0)
			2:
				speed = -speed
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision:
			if collision.get_collider() is Spike:
				got_hit.emit()
				
				

func set_mode(new_mode):
	mode = new_mode
