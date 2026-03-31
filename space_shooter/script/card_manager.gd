extends Node2D
class_name card_manager

var card_bar_ui = null

func set_ui(ui):
	card_bar_ui = ui


func add_card(card_data):
	card_bar_ui.add_card(card_data)

func execute_card(card_data,player_reference):
	card_data.use_card(player_reference)
	card_bar_ui.remove_card(card_data)
