extends Button

signal mode_change
enum Mode {JUMP, DIRECTION, ATTACK }

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		self.modulate = Color(1.545, 3.583, 3.146, 1.0)
		mode_change.emit()
