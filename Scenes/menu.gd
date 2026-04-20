extends Node

@onready var level_select = preload("res://Scenes/level_select.tscn")
@onready var playground = preload("res://Scenes/playground.tscn")

func _ready() -> void:
	AudioManager.playSong("empty shores - clip01.ogg", 0)
	pass
	
func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(level_select)

func _on_options_pressed() -> void:
	print("options")
	
func _on_exit_pressed() -> void:
	print("swooby")
	get_tree().quit()


func _on_play_button_down() -> void:
	get_tree().change_scene_to_packed(level_select)
	
