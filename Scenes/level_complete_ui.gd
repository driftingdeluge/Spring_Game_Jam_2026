extends Control

@export var next_level: PackedScene
@onready var main_menu = preload("res://Scenes/Menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_next_level_button_pressed() -> void:
	if next_level:
		get_tree().paused = false
		get_tree().change_scene_to_packed(next_level)

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(main_menu)
