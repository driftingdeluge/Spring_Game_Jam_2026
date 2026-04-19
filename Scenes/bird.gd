extends CharacterBody2D

signal projectile_fired(projectile)

@export var fly_speed := 160.0
@export var gravity := 200.0

@export var flap_force := -360.0
@export var flap_interval := 1.00
@export var flap_jitter := 0.0

# constrains the high bar
@export var min_height := 50.0
@export var max_height := 100.0

# despawn left side only
@export var despawn_x := -100.0

@onready var player = get_node("../Player")
@export var projectile_scene: PackedScene = preload("res://Scenes/projectile.tscn")

@onready var min_timer = 2.0
@onready var max_timer = 4.0

var _rng := RandomNumberGenerator.new()

func _ready():
	_rng.randomize()
	_start_shoot_loop()

func _physics_process(delta):
	velocity.x = -fly_speed
	velocity.y += gravity * delta

	if global_position.y > max_height:
		global_position.y = max_height
		if velocity.y > 0.0:
			velocity.y = flap_force * 1
	elif global_position.y < min_height:
		global_position.y = min_height
		if velocity.y < 0.0:
			velocity.y = 0.0

	move_and_slide()

	if global_position.x < despawn_x:
		queue_free()

func flap():
	velocity.y = flap_force

func shoot():
	if player == null or not is_instance_valid(player):
		return
	if projectile_scene == null:
		return
	var projectile = projectile_scene.instantiate()
	var direction = (player.global_position - global_position).normalized()
	projectile.direction = direction
	projectile.global_position = self.global_position
	get_tree().root.add_child(projectile)
	projectile_fired.emit(projectile)

func _start_shoot_loop():
	_shoot_loop()

func _shoot_loop():
	while is_inside_tree():
		await get_tree().create_timer(randf_range(min_timer, max_timer)).timeout
		shoot()
