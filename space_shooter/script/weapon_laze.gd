extends Node2D
@onready var handle_player_weapon_animation = $AnimatedSprite2D

@onready var shot_laze_butllet = $laze_bullet

@export var stat : weapon_stat
#shoting laze
var fire_delta =0
var time_charge = 0
var time_tick = 0
func _process(delta) :
	#hold 
	if Input.is_action_pressed("hold") and not Input.is_action_pressed("click") and stat.activate == true:
		stat_laze()
	if Input.is_action_just_released("hold"):
		stop_laze()
		
	# charge
	
	
	
	
	if Input.is_action_pressed("click") and not Input.is_action_pressed("hold") and stat.activate == true:
		
		time_tick = time_tick + delta
		if time_tick >= 1 and time_charge <=20 :
			time_tick =0
			time_charge = time_charge + 1
			
	if Input.is_action_just_released("click") and time_charge > 0:
		print(time_charge)
		shot_laze_butllet.activate_laze()
		shot_laze_butllet.laze_charge(time_charge)
		await get_tree().create_timer(1).timeout
		shot_laze_butllet.laze_charge_end()
		shot_laze_butllet.deactivate_laze()	
		time_charge = 0

func _input(event):
	# hien animation sac weapon
	if Input.is_action_just_pressed("click") and not handle_player_weapon_animation.is_playing():
		handle_animation()
	# tat animation sac weapon va reset frame weapon ve 0
	if Input.is_action_just_released("click") and handle_player_weapon_animation.is_playing():
		handle_player_weapon_animation.stop()
		handle_player_weapon_animation.frame = 0


#hien animation hold va kich hoat laze
func stat_laze():
	if not handle_player_weapon_animation.is_playing():
		handle_animation()
		shot_laze_butllet.activate_laze()

#tat animation hold va tat laze
func stop_laze():
	handle_player_weapon_animation.stop()
	shot_laze_butllet.deactivate_laze()



func handle_animation():
	handle_player_weapon_animation.play("default")


func deactivate():
	hide()
	stat.activate = false
	handle_player_weapon_animation.stop()


func activate():
	show()
	stat.activate = true
