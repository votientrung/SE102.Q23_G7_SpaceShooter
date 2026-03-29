extends pick_up
class_name card
@export var image : Texture2D
@export var rare : rares
@export var cost : int
@export var name : String
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
