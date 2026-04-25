extends Control
@export var player_reference : CharacterBody2D

# --- Gold ---
@onready var gold_bar = $"PanelContainer/HBoxContainer/TextureRect/stat_contaner/gold/gold bar"
@onready var gold_need_tick = $"PanelContainer/HBoxContainer/TextureRect/stat_contaner/gold/gold need tick"
@onready var gold_have_tick = $"PanelContainer/HBoxContainer/TextureRect/stat_contaner/gold/gold have tick"
var gold_have : float 
var gold_need : float = 200

# --- Mana ---
@onready var mana_bar = $"PanelContainer/HBoxContainer/TextureRect/stat_contaner/mana/mana bar"
@export var tick_count : int = 12

# --- Card ---
@onready var card_bar = $PanelContainer/HBoxContainer/TextureRect2/card_bar_ui
@export var card_scene: PackedScene
var card_stack = [] # Đây là Array
var card_hand_size = 5

func _ready():
	CardManager.set_ui(self)
	# Chờ 1 khung hình để UI tính toán xong kích thước (size)
	await get_tree().process_frame
	gold_bar.max_value = 1000
	mana_bar.max_value = tick_count
	create_mana_ticks()

func _process(_delta: float) -> void:
	if player_reference:
		gold_have = player_reference.gold
		mana_bar.value = player_reference.mana
		update_gold(player_reference.gold)

func update_gold(p_gold_have):
	if !gold_bar: return
	
	gold_bar.max_value = max(gold_need, p_gold_have)
	gold_bar.value = p_gold_have
	
	var bar_width = gold_bar.size.x
	var max_v = gold_bar.max_value
	
	# Cập nhật vị trí vạch mốc (Tick)
	gold_need_tick.position.x = (gold_need / max_v) * bar_width - (gold_need_tick.size.x / 2)
	gold_have_tick.position.x = (p_gold_have / max_v) * bar_width - (gold_have_tick.size.x / 2)

func create_mana_ticks():
	for child in mana_bar.get_children():
		child.queue_free()
		
	var bar_width = mana_bar.size.x
	var bar_height = mana_bar.size.y
	
	for i in range(1, tick_count): # Vẽ các vạch chia bên trong
		var tick = ColorRect.new()
		mana_bar.add_child(tick)
		tick.size = Vector2(2, bar_height) 
		tick.color = Color(1, 1, 1, 0.5) # Làm vạch hơi mờ đi
		tick.position.x = (float(i) / tick_count) * bar_width

# --- Card Logic ---

func add_card(card_data):
	# Nếu đầy tay, xóa lá cũ nhất (bên trái)
	if card_stack.size() >= card_hand_size:
		var oldest_card = card_stack.pop_front()
		if is_instance_valid(oldest_card):
			oldest_card.queue_free() # Phải xóa node khỏi màn hình

	var new_card_ui = card_scene.instantiate()
	card_bar.add_child(new_card_ui)
	
	# Gán dữ liệu
	if "player_reference" in new_card_ui:
		new_card_ui.player_reference = player_reference
	new_card_ui.card_info = card_data
	
	card_stack.append(new_card_ui)
	update_card_indices()

func _input(event) -> void:
	if event.is_action_pressed("use_card_1") :
		use_card(0)
	if event.is_action_pressed("use_card_2") :
		use_card(1)
	if event.is_action_pressed("use_card_3") :
		use_card(2)
	if event.is_action_pressed("use_card_4") :
		use_card(3)
	if event.is_action_pressed("use_card_5") :
		use_card(4)

func use_card(index: int):
	if card_stack.is_empty() or index >= card_stack.size(): 
		return
		
	var target_card_ui = card_stack[index]
	var data = target_card_ui.card_info
	
	if player_reference.mana >= data.cost:
		player_reference.mana -= data.cost
		CardManager.execute_card(data, player_reference)
		
		# Xóa khỏi mảng và xóa node
		card_stack.remove_at(index)
		target_card_ui.queue_free()
		
		# Cập nhật lại số thứ tự cho các lá còn lại
		update_card_indices()

func remove_card(card_data):
	# SỬA LỖI: Vì là Array nên phải duyệt để tìm card_name
	for i in range(card_stack.size()):
		var ui_node = card_stack[i]
		if ui_node.card_info.card_name == card_data.card_name:
			card_stack.remove_at(i)
			ui_node.queue_free()
			update_card_indices()
			print("Đã xóa thẻ: ", card_data.card_name)
			return

func update_card_indices():
	for i in range(card_stack.size()):
		var card_node = card_stack[i]
		if is_instance_valid(card_node) and card_node.has_method("set_card_index"):
			card_node.set_card_index(i) # Cập nhật Label số thứ tự
