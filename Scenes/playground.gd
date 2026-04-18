extends Node2D

@onready var player = $Player 

func _on_button_mode_change() -> void:
	player.set_mode()
	pass # Replace with function body.
