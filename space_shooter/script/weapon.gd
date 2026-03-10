extends Node2D
@onready var shot_origin = $shot_origin
@onready var shot_origin2 = $shot_origin2
@onready var shot_origin3 = $shot_origin3
@export var weapon_level = 1
func weapon_shot():
	if weapon_level == 1 : 
		shot_origin.shoting(Vector2.UP)
	if weapon_level == 2 :
		shot_origin2.shoting(Vector2.UP)
		shot_origin3.shoting(Vector2.UP)
	
