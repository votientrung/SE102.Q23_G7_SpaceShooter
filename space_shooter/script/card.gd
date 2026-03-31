extends pick_up
class_name card
@export var image : Texture2D
@export var rare : rares
@export var card_types: Card_types
@export var cost : int
@export var card_name : String
@export var description : String
enum Card_types {
	red,
	blue,
	green,
	colorless
}
enum rares {
	bonze,
	silver,
	gold
}
func apply_card(player):
	pass
