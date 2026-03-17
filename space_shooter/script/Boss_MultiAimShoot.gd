extends EnemySkill

class_name Boss_MultiAimShoot
func skillcast(source, target, scene_tree):
	var times = 3
	for i in times:
		spawn_trace(source, target, scene_tree)
		await scene_tree.current_scene.get_tree().create_timer(0.1).timeout
		var direction : Vector2
		direction = (target.global_position - source.global_position).normalized()
		spawn_bullet(source, direction, scene_tree)
		await scene_tree.current_scene.get_tree().create_timer(0.1).timeout
