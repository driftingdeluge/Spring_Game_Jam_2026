extends Node

@onready var player = $Player    
@onready var bird = $Bird
@onready var hud = %HUD
@onready var lose = $CanvasLayer/Lose

func _ready() -> void:
	if bird != null and bird.has_signal("projectile_fired"):
		bird.projectile_fired.connect(_on_projectile_fired)

func _on_projectile_fired(projectile) -> void:
	if projectile != null and projectile.has_signal("attack_land"):
		projectile.attack_land.connect(_on_attack_land)

func _on_attack_land() -> void:
	hud.decrement_health()
 
func _on_hud_player_dead() -> void:
	Engine.time_scale = 0
	lose.visible = true


func _on_hud_mode_attack() -> void:
	player.set_mode(0)
	
func _on_hud_mode_jump() -> void:
	player.set_mode(1)
	
func _on_hud_mode_change() -> void:
	player.set_mode(2)
