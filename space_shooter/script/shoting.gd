extends Node2D
@export var bullet_scene :PackedScene

func _input(event):
	if Input.is_action_just_pressed("shoot"):
		var bullet = bullet_scene.instantiate() as bullets
		bullet.global_position = global_position
		get_tree().current_scene.add_child(bullet)
