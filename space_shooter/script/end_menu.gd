extends Control

var is_showing := false


@export var Game_UI_Manager : CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	hide()



func show_endgame():

	if is_showing:
		return
	
	is_showing = true
	
	Game_UI_Manager.push_ui(self)
	show()


func _on_replay_pressed() -> void:
	Game_UI_Manager.pop_ui()
	get_tree().reload_current_scene()


func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GameMenu.tscn")
