extends Skill
class_name EnemySkill

@export var em_normal_bullet : PackedScene = preload("res://scenes/bullets/enemy_bullet/enemy_bullet.tscn")
@export var bullet_speed : float
@export var wavecount : int
@export var phase : int

func skillcast(source, target, scene_tree):

	spawn_bullet(source, target, scene_tree)

func spawn_bullet(source, direction, scene_tree):
	if source == null:
		return
	var bullet = em_normal_bullet.instantiate()

	bullet.global_position = source.global_position
	bullet.direction = direction
	bullet.rotation = direction.angle() + PI/2
	bullet.damage = source.damage
	bullet.speed = source.bullet_speed
	scene_tree.current_scene.add_child(bullet)

func spawn_trace(source, target, scene_tree):
	var bullet = em_normal_bullet.instantiate()
	
	bullet.global_position = source.global_position
	bullet.target = target
	bullet.damage = source.damage
	bullet.speed = source.bullet_speed
	bullet.trace_able = true
	scene_tree.current_scene.add_child(bullet)
