extends Node2D

@onready var handle_player_weapon_animation = $AnimatedSprite2D
@onready var defaul_bullet =$player_bullets
@export var bullet_scene : PackedScene

@export var player_reference : CharacterBody2D

func _ready() -> void:
	player_reference= get_parent()
var active = false
func weapon_shot():
	var lv = player_reference.weapon_lv
	if  lv == 1:
		shoting(Vector2.UP, global_position)
	if lv == 2: 
		shoting(Vector2.UP ,global_position + Vector2(-9,-9))
		shoting(Vector2.UP ,global_position + Vector2(9,-9))
	if lv == 3:
		shoting(Vector2.UP , global_position + Vector2(0,-18))
		shoting(Vector2.UP ,global_position + Vector2(-9,-9))
		shoting(Vector2.UP ,global_position + Vector2(9,-9))

#shoting 
var fire_delta =0
var fire_rate =0.2
func _process(delta) :
	#auto fire
	fire_delta=fire_delta-delta
	if Input.is_action_pressed("hold") and fire_delta <=0 and not Input.is_action_pressed("click") and active == true:
		weapon_shot()
		handle_animation()
		fire_delta=fire_rate
	
	
	

func _input(event):
	#player shoting
	if event.is_action_pressed("click") and fire_delta <=0 and not Input.is_action_pressed("hold") and active == true:
		weapon_shot()
		handle_animation()
		fire_delta=fire_rate * 0.4
	

func shoting(direc:Vector2 , pos : Vector2):
	defaul_bullet = bullet_scene.instantiate() as bullets
	defaul_bullet.damage = player_reference.damage + player_reference.modified_stat.damage
	defaul_bullet.speed = player_reference.speed + player_reference.modified_stat.speed
	defaul_bullet.global_position = pos
	defaul_bullet.direction = direc
	get_tree().current_scene.add_child(defaul_bullet)

func handle_animation():
	handle_player_weapon_animation.play("default")

func deactivate():
	set_process(false)
	hide()
	active = false
	fire_delta =0
	fire_rate =0.2
	handle_player_weapon_animation.stop()

func activate():
	show()
	active = true
	fire_delta =0
	fire_rate =0.2
	set_process(true)
