extends Control
class_name  CardUse
@export var card_frame: TextureRect

var player_reference:CharacterBody2D
@onready var index_label =$TextureRect/Label
var card_info : card:
	set(value):
		card_info = value
		$TextureRect/ImageFrame/Image.texture = card_info.image
		$TextureRect/Cost/CostText.text = str(card_info.cost)
		$"TextureRect/mana cost/CostText".text = str(card_info.mana_cost)
		$TextureRect/CostText.text = str(card_info.card_name)
		card_info.upgrade = value.upgrade
func activate_the_card():
	CardManager.execute_card(card_info,player_reference)
	queue_free()
func set_card_index(new_index: int):
	index_label.text = str(new_index + 1)
