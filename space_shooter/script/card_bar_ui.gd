extends HBoxContainer
class_name car_bar_ui

@export var card_scene: PackedScene   
@export var player_reference : CharacterBody2D
var card_map = {}
var card_hand_size = 5
func _ready():
	CardManager.set_ui(self)
func add_card(card_data):
	if card_map.size() >= card_hand_size:
		#var keys = card_map.keys()
		#var last_card_name = keys[keys.size() - 1]
		#remove_card_by_name(last_card_name)
		pass
	var card_ui_in_scene = card_scene.instantiate() 
	add_child(card_ui_in_scene)
	card_ui_in_scene.card_info = card_data
	card_map[card_data.card_name] = card_ui_in_scene
func remove_card(card_data):
	if card_map.has(card_data.card_name):
		var ui_node = card_map[card_data.card_name]
		card_map.erase(card_data.card_name)
		ui_node.queue_free()
		print(" xoa roi")

func _input(event) -> void:
	if event.is_action_pressed("use_card") :
		use_card(0)
func use_card(index :int):
	if card_map.is_empty():
		return
	if index >= card_map.size():
		return
	var card_name_key = card_map.keys()[index]
	var ui_node = card_map[card_name_key]
	var card_data = ui_node.card_info
	if player_reference.mana >= card_data.cost:
		player_reference.mana -= card_data.cost
		CardManager.execute_card(card_data, player_reference)
	else:
		print("Không đủ mana! Cần: ", card_data.mana_cost, " - Hiện có: ", player_reference.mana)
func remove_card_by_name(c_name: String):
	if card_map.has(c_name):
		var ui_node = card_map[c_name]
		card_map.erase(c_name) # Xóa khỏi data trước
		if is_instance_valid(ui_node):
			ui_node.queue_free() # Xóa khỏi màn hình
