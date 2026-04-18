extends Node2D

@export var obstacle_scene: PackedScene = preload("res://Scenes/obstacle.tscn")
@export var spawn_time := 3.0

func _ready():
	spawn_loop()

func spawn_loop():
	while true:
		await get_tree().create_timer(randf_range(1.0, spawn_time)).timeout
		spawn_obstacle()

func spawn_obstacle(): 
	var obstacle_instance = obstacle_scene.instantiate()
	obstacle_instance.position = Vector2(0, 0)
	add_child(obstacle_instance)
