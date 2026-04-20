extends Control

@export var tick_count : int = 12
@onready var mana_bar =$"mana bar"
@onready var mana_ticks =$"mana bar/mana tick"
@export var player_reference : CharacterBody2D
func _process(delta: float) -> void:
	mana_bar.value = player_reference.mana
func _ready() -> void:
	await get_tree().process_frame
	create_mana_ticks()

func create_mana_ticks():
	for child in mana_bar.get_children():
		child.queue_free()
		
	var bar_width = mana_bar.size.x
	var bar_height = mana_bar.size.y
	
	for i in range(1, tick_count+1):
		var tick = ColorRect.new()
		add_child(tick)
		
		tick.size = Vector2(1, bar_height) 
		tick.color = Color.WHITE
		tick.mouse_filter = Control.MOUSE_FILTER_IGNORE
		
		var x_pos = (float(i) / tick_count) * bar_width
		
		tick.position = Vector2(x_pos, 0)
