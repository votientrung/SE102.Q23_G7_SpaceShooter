extends Skill
class_name EnemySkill

@export var enemy_bullet : PackedScene = preload("res://scenes/bullets/enemy_bullet.tscn")


func skillcast(source, target, scene_tree):

	spawn_bullet(source, target, scene_tree)

func spawn_bullet(source, direction, scene_tree):

	var bullet = enemy_bullet.instantiate()

	bullet.global_position = source.global_position
	bullet.direction = direction
	bullet.rotation = direction.angle() + PI/2
	bullet.damage = source.damage
	bullet.speed = 200
	scene_tree.current_scene.add_child(bullet)
