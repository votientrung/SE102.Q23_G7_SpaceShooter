extends Node2D
@export var bullet_scene :PackedScene

func shoting(direc:Vector2 ):
	var bullet = bullet_scene.instantiate() as bullets
	bullet.global_position = global_position
	bullet.direction = direc
	get_tree().current_scene.add_child(bullet)
