extends Control
class_name Shop



@export var sell_card: PackedScene
@export var Card_list: Array[card]
@onready var card_container: HBoxContainer = $"window/CardContainer"

@export var player_reference:CharacterBody2D

@export var Skill_card : PackedScene
@export var skill_list : Array[card]
@onready var Skill_card_container: HBoxContainer = $"window/SkillCardContainer"
@onready var exit_button: TextureRect = $"window/Continue"
var hovering: bool



func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	#hide()
	#set up card de ban
	set_shop()


func _process(delta: float) -> void:
	if is_mouse_over_card():
		hovering = true
		exit_button.scale = Vector2(1.1, 1.1)
	else:
		hovering = false
		exit_button.scale = Vector2(1.0, 1.0)
	
	$"window/GoldLeft".text = str(player_reference.gold)


func is_mouse_over_card() -> bool:
	var mouse_pos: Vector2 = get_global_mouse_position()
	var sprite_rect = Rect2(exit_button.global_position, exit_button.texture.get_size())
	return sprite_rect.has_point(mouse_pos)

func _input(event) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and hovering:
			
			Close()
			
			pass

func Open(index):
	get_tree().paused = true
	tax_gold(index)
	show()
	set_shop()

func Close():
	hide()
	get_tree().paused = false


func tax_gold(index):
	if player_reference.gold < index:
		#man  hinh  thua
		return
	player_reference.gold-=index

func clear_shop():
	if card_container:
		for slot in card_container.get_children():
			slot.queue_free()

	if Skill_card_container:
		for slot in Skill_card_container.get_children():
			slot.queue_free()

func set_shop():
	clear_shop()
	if card_container == null:
		return
	for i in range(4):
		var sell_card_instance = sell_card.instantiate() as SellCard
		sell_card_instance.card_info = Card_list.pick_random()

		sell_card_instance.player_reference = player_reference
		card_container.add_child(sell_card_instance)
	
	
	var Skill_card_instance = Skill_card.instantiate()
	Skill_card_instance.card_info = skill_list.pick_random()
	Skill_card_instance.player_reference = player_reference
	Skill_card_container.add_child(Skill_card_instance)
	
	print("done set up")
