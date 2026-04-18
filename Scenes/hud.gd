extends Control

@onready var attack = %Attack
@onready var jump = %Jump
@onready var direction = %ChangeDirection

#@onready enum = {ATTACK, JUMP, CHANGE}
@onready var state = [attack, jump, direction]
@onready var active = 0
@onready var hover = 0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left"):
		var prev = hover
		hover = ((hover - 1) % 3 + 3) % 3
		if active != prev:
			color_inactive(prev)
		if active != hover:
			color_option()
	elif Input.is_action_just_pressed("right"):
		var prev = hover
		hover = ((hover + 1) % 3)
		if active != prev:
			color_inactive(prev)
		if active != hover:
			color_option()
	elif Input.is_action_just_pressed("jump"):
		var prev = active
		active = hover
		color_active()

func color_inactive(select) -> void:
	state[select].modulate = Color(1.0, 1.0, 1.0, 1.0)
	
func color_active() -> void:
	for i in 3:
		if hover == i:
			state[active].modulate = Color(0.169, 0.678, 0.267, 1.0)
		else:
			state[i].modulate = Color(1.0, 1.0, 1.0, 1.0)
	
func color_option() -> void:
	state[hover].modulate = Color(0.867, 0.679, 0.265, 1.0)
