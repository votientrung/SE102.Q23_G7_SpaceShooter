extends Node2D
@onready var handle_player_weapon_animation = $AnimatedSprite2D

@onready var shot_laze_butllet = $laze_bullet

@export var stat : weapon_stat
var time_charge = 0
var time_tick = 0
var active = false
func _ready() -> void:
	shot_laze_butllet.damage = stat.damage/10
func _process(delta) :
	if Input.is_action_pressed("click") and not Input.is_action_pressed("hold") and active == true:
		time_tick = time_tick + delta * stat.weapon_level
		if time_tick >= 1 and time_charge <= 5 :
			time_tick =0
			time_charge = time_charge + 1
	if Input.is_action_just_released("click") and time_charge > 0 and active == true :
		shot_laze_butllet.activate_laze()
		shot_laze_butllet.laze_charge(time_charge , shot_laze_butllet.damage * pow(1.5,time_charge))
		await get_tree().create_timer(1).timeout
		shot_laze_butllet.laze_charge_end(stat.damage/10)
		stop_laze()
		time_charge = 0

func _input(event):
	if Input.is_action_just_pressed("hold") and not Input.is_action_pressed("click") and active == true:
		stat_laze()
	if Input.is_action_just_released("hold") and active == true :
		stop_laze()
	# hien animation sac weapon
	if Input.is_action_just_pressed("click") and not handle_player_weapon_animation.is_playing() and active == true :
		handle_animation()
	if Input.is_action_just_released("click") and time_charge <=0 and handle_player_weapon_animation.is_playing():
		handle_player_weapon_animation.play("deactivate")


#hien animation hold va kich hoat laze
func stat_laze():
	if not handle_player_weapon_animation.is_playing():
		handle_animation()
		shot_laze_butllet.activate_laze()
		shot_laze_butllet.scale = Vector2(stat.weapon_level,1)

#tat animation hold va tat laze
func stop_laze():
	handle_player_weapon_animation.play("deactivate")
	shot_laze_butllet.deactivate_laze()



func handle_animation():
	handle_player_weapon_animation.play("default")


func deactivate():
	set_process(false)
	hide()
	active = false
	shot_laze_butllet.deactivate_laze()
	time_charge =0
	time_tick =0
	


func activate():
	show()
	active = true
	set_process(true)
