extends Area2D

var speed = 300
var direction = Vector2.ZERO

signal attack_land

func _ready():
	pass

func _physics_process(delta):
	if direction != Vector2.ZERO:
		position += direction * speed * delta

func _on_body_entered(body):
	if body.is_in_group("player"):
		attack_land.emit()
		queue_free()
