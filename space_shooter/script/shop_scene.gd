extends Control
class_name Shop



@export var sell_card: PackedScene
#them array resouce card  chi so
@export var card_container: HBoxContainer

var player_reference:CharacterBody2D

@export var Skill_card : PackedScene
#them array reouse card skill
@export var Skill_card_container: HBoxContainer
@export var exit_frame: TextureRect
var hovering: bool


func _ready() -> void:
	#hide()
	#set up card de ban
	
	for i in range(4):
		var sell_card_instance = sell_card.instantiate()
		card_container.add_child(sell_card_instance)
	
	
	var Skill_card_instance = Skill_card.instantiate()
	Skill_card_container.add_child(Skill_card_instance)


func _process(delta: float) -> void:
	if is_mouse_over_card():
		hovering = true
		exit_frame.scale = Vector2(1.1, 1.1)
	else:
		hovering = false
		exit_frame.scale = Vector2(1.0, 1.0)


func is_mouse_over_card() -> bool:
	var mouse_pos: Vector2 = get_global_mouse_position()
	var sprite_rect = Rect2(exit_frame.global_position, exit_frame.texture.get_size())
	return sprite_rect.has_point(mouse_pos)

func _input(event) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and hovering:
			
			#add thing to do here
			
			pass

func Open():
	pass

func Close():
	pass

func tax_gold(index):
	pass
