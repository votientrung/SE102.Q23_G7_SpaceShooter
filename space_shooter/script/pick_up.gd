extends Resource
class_name pick_up

@export var frame : SpriteFrames
@export var animation : String = "default"
@export var type : types

@export var speed : float = 300
@export var direction : Vector2 = Vector2.DOWN
@export var stat : float = 1
enum types {
	gold,
	energy,
	weapon_change_to_default,
	weapon_change_to_laze,
	weapon_change_to_snake,
	pick_up_card,
	unique_card
}
