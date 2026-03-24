extends Control
class_name car_bar_ui

@export var card_scene: PackedScene   
@export var container: HBoxContainer

var card_map = {}

func _ready():
	CardManager.set_ui(self)

func add_card(card_data):
	if card_map.has(card_data.name):
		card_map[card_data.name].add_stack()
	else:
		var card_ui_in_scene = card_scene.instantiate() as card_ui
		container.add_child(card_ui_in_scene)
		card_ui_in_scene.set_data(card_data)
		card_map[card_data.name] = card_ui_in_scene
