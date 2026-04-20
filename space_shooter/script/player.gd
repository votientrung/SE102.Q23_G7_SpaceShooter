extends CharacterBody2D
@onready var collistion_rect:CollisionShape2D = $CollisionShape2D
@onready var animation_player_get_hit =$AnimationPlayer
@onready var default = $weapon_default
@onready var laze = $weapon_laze
@onready var snake = $weapon_snake

@export var base_stat : stats
@export var modified_stat : stats

@onready var weapons_array = [default,laze,snake]

@onready var gold_bar =$"../UI/HUD/PanelContainer/HBoxContainer/stat_contaner/gold/gold bar"
#@onready var bonus_bar =$"../UI/HUD/PanelContainer/HBoxContainer/stat_contaner/gold_bar_gr/bonus bar"
@onready var mana_bar =$"../UI/HUD/PanelContainer/HBoxContainer/stat_contaner/mana/mana bar"

var current_weapon_index = 0
#bound size
var bound_size_x
var bound_size_y
var start_bound_x
var end_bound_x
var start_bound_y
var end_bound_y

#player stat thuc te
var gold : float = 50 :
	set(value):
		gold= max(value,0)
		if gold_bar:
			gold_bar.value = gold
		#if bonus_bar:
			#if gold >400:
				#bonus_bar.visible = true
				#bonus_bar.value = gold - 400
			#else :
				#bonus_bar.visible =false
		if gold <=0:
			die()
var mana : float = 0 :
	set(value):
		mana =value
		if mana_bar:
			mana_bar.value = mana
var gold_regent : float =0 :
	set(value):
		gold_regent=value
var mana_regent : float =1:
	set(value):
		mana_regent=value
var gold_modified : float =1.0:
	set(value):
		gold_modified =value
var mana_modified : float =1.0:
	set(value):
		mana_modified =value
var armor : float =0:
	set(value):
		armor=value
var damage : float =1:
	set(value):
		damage=value
var damage_modified : float =1.0:
	set(value):
		damage_modified=value
var might : float =1.0:
	set(value):
		might=value
var scale_bullet : float =1.0:
	set(value):
		scale_bullet=value
var speed : float = 300 :
	set(value):
		speed=value
var luck : float =  -10:
	set(value):
		luck = value
var weapon_lv : float = 1:
	set(value):
		weapon_lv = value
var weapon_current : float = 0:
	set(value):
		if value <0 or value >=weapons_array.size():
			return
		if (current_weapon_index != value):
			weapons_array[current_weapon_index].deactivate()
			current_weapon_index = value
			weapon_current = value
			weapons_array[current_weapon_index].activate()
		else:
			if weapon_lv <3:
				weapon_lv += 1


func _ready() -> void:
	set_base_stats(base_stat)
	gold_bar.max_value = 1000
	gold_bar.value = gold
	mana_bar.max_value = 12
	mana_bar.value = mana
	# setting camera
	bound_size_x = collistion_rect.shape.get_rect().size.x
	bound_size_y = collistion_rect.shape.get_rect().size.y
	var rect = get_viewport().get_visible_rect()
	var camera = get_viewport().get_camera_2d()
	var camera_position =camera.position
	start_bound_x = camera_position.x- (rect.size.x)/2
	end_bound_x = camera_position.x + (rect.size.x)/2
	start_bound_y = camera_position.y - (rect.size.y)/2
	end_bound_y = camera_position.y + (rect.size.y)/2 - 150
	
	default.activate()
	laze.deactivate()
	snake.deactivate()
	

func _process(delta):
	# lay vi tri chuot
	var mouse_pos = get_global_mouse_position()
	# charater bondry
	mouse_pos.x = clamp(mouse_pos.x, start_bound_x + bound_size_x * transform.get_scale().x
	,end_bound_x - bound_size_x * transform.get_scale().x)
	mouse_pos.y = clamp(mouse_pos.y, start_bound_y + bound_size_y * transform.get_scale().y
	, end_bound_y - bound_size_y * transform.get_scale().y)
	
	position = mouse_pos
	
	#die
	if gold < 0:
		die()

#take dam
var can_take_dmg =true
func gold_take(damage):
	if can_take_dmg == false:
		return
	can_take_dmg =false
	print("take dmg")
	print("dmg " , damage)
	gold -= damage
	animation_player_get_hit.play("flash")
	await  get_tree().create_timer(6).timeout
	animation_player_get_hit.stop()
	can_take_dmg =true
	print("gold left " , gold)

func die():
	queue_free()

func set_base_stats(s : stats):
	gold=s.gold
	mana=s.mana
	gold_regent=s.gold_regent
	mana_regent=s.mana_regent
	gold_modified=s.gold_modified
	mana_modified=s.mana_modified
	armor=s.armor
	damage=s.damage
	damage_modified=s.damage_modified
	might=s.might
	scale_bullet=s.scale_bullet
	speed=s.speed
	luck=s.luck
	weapon_lv=s.weapon_lv
	weapon_current=s.weapon_current

func gain_gold(amount) :
	gold += amount
