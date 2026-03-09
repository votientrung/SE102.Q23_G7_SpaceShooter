extends Area2D
class_name bullets
@export var damage =1
@export var speed =300
@export var direction= Vector2.UP
func _process(delta):
	position += direction*speed*delta
