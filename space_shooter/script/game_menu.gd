extends Node2D

func _ready() -> void:
	pass

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/gameplay.tscn")


func _on_shop_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MenuShop.tscn")


func _on_setting_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
