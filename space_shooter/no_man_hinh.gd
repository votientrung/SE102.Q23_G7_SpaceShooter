extends Area2D
class_name fullscreen_explosion
var damage = 999
func _ready():
	$AnimatedSprite2D.play("default")
	await get_tree().create_timer(0.5).timeout
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("damage_take"):
		body.damage_take(damage)
