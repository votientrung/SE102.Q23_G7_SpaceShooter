extends Node2D
class_name pick_up_manager

@export var pick_up_sence : PackedScene
@export var drop_list_weapon : Array[pick_up] = []
@export var drop_list_gold_and_energy : Array[pick_up] = []
@export var drop_list_stat : Array[pick_up] = []

func spaw_pic_up(position: Vector2, data_pickup: pick_up):
	var item = pick_up_sence.instantiate() 
	item.stat =data_pickup
	item.global_position = position
	get_tree().current_scene.add_child(item)

func drop_item(position: Vector2):
	var random = randf()
	if random < 0.25 :
		spaw_pic_up(position,drop_list_weapon.pick_random())
	elif random <0.3 :
		spaw_pic_up(position,drop_list_stat.pick_random())
	elif random <0.7 :
		spaw_pic_up(position,drop_list_gold_and_energy.pick_random())
