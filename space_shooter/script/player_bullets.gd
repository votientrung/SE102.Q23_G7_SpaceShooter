extends Area2D
class_name bullets
@export var damage =1
@export var speed =300
@export var direction= Vector2.UP
func _process(delta):
	position += direction*speed*delta
	
	if global_position.y > get_viewport_rect().size.y +1:
		queue_free()
	if global_position.y < -10:
		queue_free()
	if global_position.x > get_viewport_rect().size.x +1:
		queue_free()
	if global_position.x < -10:
		queue_free()
