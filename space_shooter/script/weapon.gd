extends Node2D
@onready var shot_origin = $shot_origin
@onready var shot_origin2 = $shot_origin2
@onready var shot_origin3 = $shot_origin3

@export var stat : weapon_stat
func weapon_shot():
	if  stat.weapon_level == 1:
		shot_origin.shoting(Vector2.UP)
	if stat.weapon_level == 2: 
		shot_origin2.shoting(Vector2.UP)
		shot_origin3.shoting(Vector2.UP)
	if stat.weapon_level == 3:
		shot_origin.shoting(Vector2.UP)
		shot_origin2.shoting(Vector2.UP)
		shot_origin3.shoting(Vector2.UP)

#shoting 
var fire_delta =0
func _process(delta) :
	#auto fire
	fire_delta=fire_delta-delta
	if Input.is_action_pressed("hold") and fire_delta <=0 and not Input.is_action_pressed("click"):
		weapon_shot()
		fire_delta=stat.fire_rate

func _input(event):
	#player shoting
	if event.is_action_pressed("click") and fire_delta <=0 and not Input.is_action_pressed("hold") :
		weapon_shot()
		fire_delta=stat.fire_rate * 0.4
	
