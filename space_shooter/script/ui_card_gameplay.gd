extends Control
class_name card_ui
@onready var background = $backgound
@onready var icon = $icon
@onready var vien_card = $vien_card
@onready var vien_art = $vien_art
@onready var khung_dicrip = $khung_dicrip
@onready var cost_icon = $cost_icon
@onready var stack_label = $stack_card
@onready var cost_lable =$cost_icon/cost_lable
@onready var dicrip=$khung_dicrip/RichTextLabel
var data
var count := 1

func set_data(card_data):
	data = card_data
	icon.texture = data.image
	khung_dicrip.texture=preload("res://assets/image/cardspickup/khung_dicrip.tres")
	match data.type:
		data.types.red:
			background.texture =preload("res://assets/image/cardspickup/card_red_background.tres")
		data.types.blue:
			background.texture =preload("res://assets/image/cardspickup/card_blue_background.tres")
		data.types.green:
			background.texture =preload("res://assets/image/cardspickup/card_green_background.tres")
		data.types.colorless:
			background.texture=preload("res://assets/image/cardspickup/card_colorless_background.tres")
	match data.rare:
		data.rares.bonze:
			vien_card.texture=preload("res://assets/image/cardspickup/khung_bonze.tres")
			vien_art.texture=preload("res://assets/image/cardspickup/vien_art_bonze.tres")
			cost_icon.texture=preload("res://assets/image/cardspickup/cost_bonze.tres")
		data.rares.silver:
			vien_card.texture=preload("res://assets/image/cardspickup/khung_silver.tres")
			vien_art.texture=preload("res://assets/image/cardspickup/vien_art_silver.tres")
			cost_icon.texture=preload("res://assets/image/cardspickup/cost_silver.tres")
		data.rares.gold:
			vien_card.texture=preload("res://assets/image/cardspickup/khung_gold.tres")
			vien_art.texture=preload("res://assets/image/cardspickup/vien_art_gold.tres")
			cost_icon.texture=preload("res://assets/image/cardspickup/cost_gold.tres")
	cost_lable.text = str(data.cost)
	dicrip.text = data.description
	update_stack()


func add_stack():
	count += 1
	update_stack()


func update_stack():
	if count > 1:
		stack_label.text = "x" + str(count)
		stack_label.visible = true
	else:
		stack_label.visible = false
