extends EnemySkill

class_name SkillShootDown

func skillcast(source, target, scene_tree):
	spawn_bullet(source, Vector2.DOWN, scene_tree)
