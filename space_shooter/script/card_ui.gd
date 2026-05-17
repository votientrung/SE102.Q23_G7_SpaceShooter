extends Control
class_name  CardUse
@export var card_frame: TextureRect

var player_reference:CharacterBody2D
@onready var index_label =$TextureRect/Label
@onready var stack_label = $TextureRect/stack
var quantity: int = 1
var card_info : card:
	set(value):
		card_info = value
		$TextureRect/ImageFrame/Image.texture = card_info.image
		$"TextureRect/Cost mana/CostText".text = str(card_info.mana_cost)
		$TextureRect/CostText.text = str(card_info.card_name)
		card_info.upgrade = value.upgrade
func set_quantity(value: int):
	quantity = value
	if stack_label:
		if quantity <= 1:
			stack_label.visible = false
		else:
			stack_label.visible = true
			$TextureRect/stack/stack_text.text = str(quantity)
func update_ui():
	if quantity > 1:
		$TextureRect/stack/stack_text.text = "x" + str(quantity)
		$TextureRect/stack/stack_text.show()
	else:
		$TextureRect/stack/stack_text.hide()
func activate_the_card():
	CardManager.execute_card(card_info,player_reference)
	queue_free()
func set_card_index(new_index: int):
	index_label.text = str(new_index + 1)
