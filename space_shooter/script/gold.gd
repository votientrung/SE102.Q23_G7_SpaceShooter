extends Control
@onready var gold_bar = $"gold bar"
@onready var gold_ticks = $"gold tick"
@onready var gold_need_tick = $"gold need tick"
@onready var gold_have_tick =$"gold have tick"
@export var player_reference : CharacterBody2D 
var gold_have : float 
var gold_need : float = 200
func _process(delta: float) -> void:
	var gold_have=player_reference.gold
	update_gold(gold_have)
func update_gold(gold_have):
	if gold_have <= gold_need :
		gold_bar.max_value = gold_need
	else :
		gold_bar.max_value = gold_have
	gold_bar.value=gold_have
	var bar_width = gold_bar.size.x
	var max_v = gold_bar.max_value
	
	var ratio = gold_need / max_v
	var target_x = ratio * bar_width
	
	gold_need_tick.position.x = gold_bar.position.x + target_x - (gold_need_tick.size.x / 2)
	
	var ratio_have = gold_have / max_v
	var target_x_have = ratio_have * bar_width
	gold_have_tick.position.x = gold_bar.position.x + target_x_have - (gold_have_tick.size.x / 2)
