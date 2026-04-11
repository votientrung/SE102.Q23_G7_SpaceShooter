extends HBoxContainer
class_name car_bar_ui

@export var card_scene: PackedScene   
@export var player_reference : CharacterBody2D
var card_map = {}
func _ready():
	CardManager.set_ui(self)
func add_card(card_data):
	if card_map.has(card_data.card_name):
		card_map[card_data.card_name].add_stack()
	else:
		var card_ui_in_scene = card_scene.instantiate() as card_ui
		add_child(card_ui_in_scene)
		card_ui_in_scene.set_data(card_data)
		card_map[card_data.card_name] = card_ui_in_scene
func remove_card(card_data):
	if card_map.has(card_data.card_name):
		var ui_node = card_map[card_data.card_name]
		ui_node.remove_stack()
		if ui_node.count <=0:
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
	var card_data = ui_node.data
	if player_reference.mana >= card_data.cost:
		player_reference.mana -= card_data.cost
		CardManager.execute_card(card_data, player_reference)
	else:
		print("Không đủ mana! Cần: ", card_data.mana_cost, " - Hiện có: ", player_reference.mana)
