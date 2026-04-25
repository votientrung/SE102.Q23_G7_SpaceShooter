extends Control
class_name SellCard

@export var card_frame: TextureRect

var upgrade : stats


var player_reference:CharacterBody2D
var hovering: bool
var card_info : card:
	set(value):
		card_info = value
		$TextureRect/ImageFrame/Image.texture = card_info.image
		$TextureRect/Description.text = card_info.description
		$TextureRect/Cost/CostText.text = str(card_info.cost)
		$"TextureRect/mana cost/CostText".text = str(card_info.mana_cost)
		$TextureRect/CostText.text = str(card_info.card_name)
		card_info.upgrade = value.upgrade



func _process(_delta):
	if is_mouse_over_card():
		hovering = true
		card_frame.scale = Vector2(1.1, 1.1)
	else:
		hovering = false
		card_frame.scale = Vector2(1.0, 1.0)

func is_mouse_over_card() -> bool:
	return card_frame.get_global_rect().has_point(get_global_mouse_position())

func _input(event) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and hovering:
			
			if player_reference.gold >= card_info.cost and  player_reference.gold != null:
				player_reference.gold -= card_info.cost
				card_info.apply_card(player_reference)
				print(player_reference.damage)
				self.queue_free()
			else :
				print(" ban ngheo vl")
				return
