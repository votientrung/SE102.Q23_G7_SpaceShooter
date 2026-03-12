extends Area2D
class_name bullets

@onready var ha= $AnimatedSprite2D
@export var damage : float = 1
@export var speed : float = 300
@export var direction : Vector2
func _process(delta):
	position += direction*speed*delta
	# remove bullet from scene
	if global_position.y > get_viewport_rect().size.y +1:
		queue_free()
	if global_position.y < -10:
		queue_free()
	if global_position.x > get_viewport_rect().size.x +1:
		queue_free()
	if global_position.x < -10:
		queue_free()
	# handle animation
	handle_animation()

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.has_method("damage_take"):
			body.damage_take(damage)
			queue_free()



func handle_animation():
	ha.play("default")
