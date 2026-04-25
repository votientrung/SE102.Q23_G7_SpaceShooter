extends Control
class_name  UseCard
@export var card_frame: TextureRect

var upgrade : stats

var player_reference:CharacterBody2D
var card_info : card:
	set(value):
		card_info = value
		$TextureRect/ImageFrame/Image.texture = card_info.image
		$TextureRect/Description.text = card_info.description
		$TextureRect/Cost/CostText.text = str(card_info.cost)
		$"TextureRect/mana cost/CostText".text = str(card_info.mana_cost)
		$TextureRect/CostText.text = str(card_info.card_name)
		card_info.upgrade = value.upgrade
func activate_the_card():
	CardManager.execute_card(card_info,player_reference)
	queue_free()
