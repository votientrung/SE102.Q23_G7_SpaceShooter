extends Node2D

@onready var handle_player_weapon_animation = $AnimatedSprite2D
@onready var shot_snake_bullet = $snake_bullet
@export var bullet_snake_scene :PackedScene
@export var stat : weapon_stat
@export var can_spawn : bool = true
var active = false
func _process(delta):
	if shot_snake_bullet ==null and can_spawn == true and active == true:
		spawn_shot_snake_bullet()
func _input(event):
	if Input.is_action_just_pressed("click") and active == true and shot_snake_bullet !=null:
		handle_animation()
		shot_snake_bullet.fire = true
		shot_snake_bullet.reparent(get_tree().current_scene)
		shot_snake_bullet.direction = Vector2.UP
	if Input.is_action_just_pressed("hold") and shot_snake_bullet != null and shot_snake_bullet.fire == true:
		shot_snake_bullet.explode(stat.weapon_level+2)
		can_spawn=false
		await get_tree().create_timer(5-stat.weapon_level).timeout
		can_spawn=true

func spawn_shot_snake_bullet():
	shot_snake_bullet = bullet_snake_scene.instantiate() as snakes 
	shot_snake_bullet.damage = stat.damage
	shot_snake_bullet.speed = stat.speed * stat.weapon_level
	shot_snake_bullet.scale = Vector2(stat.weapon_level + 2,stat.weapon_level + 2)
	shot_snake_bullet.position = Vector2(0,-70)
	add_child(shot_snake_bullet)


func handle_animation():
	handle_player_weapon_animation.play("default")

func deactivate():
	set_process(false)
	hide()
	active = false
	if shot_snake_bullet != null :
		shot_snake_bullet.explode(stat.weapon_level+2)
	

func activate():
	show()
	active = true
	set_process(true)
