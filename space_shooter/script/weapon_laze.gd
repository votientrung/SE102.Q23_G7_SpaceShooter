extends Node2D
@onready var handle_player_weapon_animation = $AnimatedSprite2D

@onready var shot_laze_origin = $shot_laze_origin

@export var stat : weapon_stat
func weapon_laze_shot():
	if  stat.weapon_level == 1:
		shot_laze_origin.lazing(Vector2.UP)

#shoting laze
var fire_delta =0
func _process(delta) :
	#auto fire
	fire_delta=fire_delta-delta
	if Input.is_action_pressed("hold") and fire_delta <=0 and not Input.is_action_pressed("click") and stat.activate == true:
		weapon_laze_shot()
		handle_animation()
		fire_delta=stat.fire_rate
	
	
	

func _input(event):
	#player shoting
	if event.is_action_pressed("click") and fire_delta <=0 and not Input.is_action_pressed("hold") and stat.activate == true:
		weapon_laze_shot()
		handle_animation()
		fire_delta=stat.fire_rate * 0.4
	
func handle_animation():
	handle_player_weapon_animation.play("default")


func deactivate():
	hide()
	stat.activate = false
	handle_player_weapon_animation.stop()


func activate():
	show()
	stat.activate = true
	handle_player_weapon_animation.play("default")
