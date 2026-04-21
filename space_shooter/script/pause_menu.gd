extends Control

var target_position: Vector2
var speed := 1000
var is_open := false
var is_transitioning := false

@export var Game_UI_Manager : CanvasLayer



func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

	global_position = Vector2(0, 1000)
	target_position = global_position
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	

	# Kiểm tra đã tới vị trí chưa
	if global_position == target_position:
		is_transitioning = false
		
		# Nếu đã đóng xong thì hide
		if not is_open:
			hide()


func _input(event):
	if event.is_action_pressed("pause") and not is_transitioning:
		if is_open:
			close_pause_menu()
		else:
			open_pause_menu()

func open_pause_menu():
	is_open = true
	is_transitioning = true

	show()
	target_position = Vector2(0,0)
	var tween = create_tween()
	tween.tween_property(self, "global_position", target_position, 0.3)
	await tween.finished
	Game_UI_Manager.push_ui(self)

func close_pause_menu():
	is_open = false
	is_transitioning = true
	
	target_position = Vector2(0, 1000)
	var tween = create_tween()
	tween.tween_property(self, "global_position", target_position, 0.3)
	await tween.finished
	
	Game_UI_Manager.pop_ui()


func _on_continue_pressed() -> void:
	close_pause_menu()


func _on_replay_pressed() -> void:
	get_tree().reload_current_scene()


func _on_setting_pressed() -> void:
	pass # Replace with function body.


func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GameMenu.tscn")
