extends Resource
class_name card
@export var image : Texture2D
@export var scale : Vector2 = Vector2(1,1)
@export var type : types
@export var rare : rares
@export var cost : int
@export var name : String
@export var description : String
enum types {
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
