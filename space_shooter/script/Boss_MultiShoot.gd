extends EnemySkill

class_name Boss_MultiShoot
func skillcast(source, target, scene_tree):
	var times = 4
	for i in times:
		spawn_bullet(source, Vector2.DOWN, scene_tree)
		await scene_tree.current_scene.get_tree().create_timer(0.1).timeout
