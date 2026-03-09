extends Node2D
@onready var shot_origin = $shot_origin
@onready var shot_origin2 = $shot_origin2
func weapon_shot():
	shot_origin.shoting(Vector2.UP)
	shot_origin2.shoting(Vector2.UP)
