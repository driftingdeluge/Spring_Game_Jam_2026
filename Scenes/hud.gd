extends Control

@onready var attack = %Attack
@onready var jump = %Jump
@onready var direction = %ChangeDirection

@onready var health = %Health
@onready var hp = 3

@onready var state = [attack, jump, direction]
@onready var active = 0
@onready var hover = 0

signal mode_attack
signal mode_jump
signal mode_change
signal player_dead

func _ready() -> void:
	color_active()
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("changeMode"):
		var prev = active
		active = ((active + 1) % 3)
		color_inactive(prev)
		color_active()
		match active:
			0: 
				mode_attack.emit()
			1:
				mode_jump.emit()
			2:
				mode_change.emit()


func color_inactive(select) -> void:
	state[select].modulate = Color(1.0, 1.0, 1.0, 1.0)
	
func color_active() -> void:
	state[active].modulate = Color(0.169, 0.678, 0.267, 1.0)
	
func color_option() -> void:
	state[hover].modulate = Color(0.867, 0.679, 0.265, 1.0)

func decrement_health() -> void:
	hp -= 1
	health.text = "Health: " + str(hp)
	if hp <= 0:
		player_dead.emit()
	
