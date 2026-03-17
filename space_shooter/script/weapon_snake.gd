extends Node2D

@onready var handle_player_weapon_animation = $AnimatedSprite2D
@onready var shot_snake_bullet = $snake_bullet
@export var bullet_snake_scene :PackedScene
@export var stat : weapon_stat
@export var can_spawn : bool = true
func _process(delta):
	if shot_snake_bullet ==null and can_spawn == true:
		spawn_shot_snake_bullet()
func _input(event):
	if Input.is_action_just_pressed("click") and stat.activate == true and shot_snake_bullet !=null:
		handle_animation()
		shot_snake_bullet.fire = true
		shot_snake_bullet.reparent(get_tree().current_scene)
		shot_snake_bullet.direction = Vector2.UP
	if Input.is_action_just_pressed("hold") and shot_snake_bullet != null and shot_snake_bullet.fire == true:
		shot_snake_bullet.explode()
		can_spawn=false
		await get_tree().create_timer(5).timeout
		can_spawn=true

func spawn_shot_snake_bullet():
	shot_snake_bullet = bullet_snake_scene.instantiate() as snakes 
	add_child(shot_snake_bullet)
	shot_snake_bullet.position = Vector2(0,-70)

func handle_animation():
	handle_player_weapon_animation.play("default")

func deactivate():
	hide()
	stat.activate = false
	handle_player_weapon_animation.stop()

func activate():
	show()
	stat.activate = true
	
