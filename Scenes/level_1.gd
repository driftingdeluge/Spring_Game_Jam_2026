extends Node2D

# Level 1 specific stuff

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_death_barrier_body_entered(body: Node2D) -> void:
	get_tree().reload_current_scene()


func _on_player_got_hit() -> void:
	if get_tree():
		get_tree().reload_current_scene()


func _on_level_complete_barrier_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.name == "Player" and get_tree():
		get_tree().paused = true
		$CanvasLayer/LevelCompleteUI.show()
