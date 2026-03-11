extends EnemySkill

class_name SkillShootAim

func skillcast(source, target, scene_tree):
	var direction : Vector2
	direction = (target.global_position - source.global_position).normalized()
	spawn_bullet(source, direction, scene_tree)
	
