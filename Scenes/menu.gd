extends Node

func _ready() -> void:
	AudioManager.playSong("empty shores - clip01.ogg", 0)
	pass
	
func _on_play_pressed() -> void:
	GameManager.goto_scene("res://Scenes/level1.tscn")
	pass

func _on_options_pressed() -> void:
	print("options")
	
func _on_exit_pressed() -> void:
	print("swooby")
	get_tree().quit()


func _on_play_button_down() -> void:
	GameManager.goto_scene("res://Scenes/playground.tscn")
	
