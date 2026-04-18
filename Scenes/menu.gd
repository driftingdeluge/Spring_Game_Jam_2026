extends Node

func _ready() -> void:
	# Play a song?
	pass # Replace with function body.
	
func _on_play_pressed() -> void:
	GameManager.goto_scene("res://Scenes/Menu.tscn")

func _on_options_pressed() -> void:
	print("options")
	
func _on_exit_pressed() -> void:
	print("swooby")
	get_tree().quit()
