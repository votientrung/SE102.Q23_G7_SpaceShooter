extends Node2D

@onready var handle_player_weapon_animation = $AnimatedSprite2D
@onready var shot_snake_bullet = $snake_bullet
@export var stat : weapon_stat
func _process(delta):
	pass
func _input(event):
	if Input.is_action_just_pressed("click") and not Input.is_action_pressed("hold") and stat.activate == true:
		handle_animation()


func handle_animation():
	handle_player_weapon_animation.play("default")

func deactivate():
	hide()
	stat.activate = false
	handle_player_weapon_animation.stop()

func activate():
	show()
	stat.activate = true
	
