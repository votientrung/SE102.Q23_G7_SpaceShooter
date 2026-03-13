extends Node2D
@export var laze_scene :PackedScene
func lazing(direc:Vector2):
	var laze = laze_scene.instantiate() as lazes
	laze.global_position = global_position
	laze.direction = direc
	get_tree().current_scene.add_child(laze)
