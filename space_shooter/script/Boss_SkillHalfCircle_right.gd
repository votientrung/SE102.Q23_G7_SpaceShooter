extends EnemySkill

class_name Boss_HalfCircle

func skillcast(source, target, scene_tree):
	var start_angle = -PI/2
	var end_angle = PI/2
	var bullet_count = 7
	
	for i in bullet_count:
		var t = float(i) / (bullet_count - 1)
		var angle = lerp(start_angle, end_angle, t)
		var direction = Vector2.DOWN.rotated(angle)
		spawn_bullet(source, direction, scene_tree)
		await scene_tree.current_scene.get_tree().create_timer(0.1).timeout
	
	for i in bullet_count:
		var t = float(i) / (bullet_count - 1)
		var angle = lerp(end_angle, start_angle, t)
		var direction = Vector2.DOWN.rotated(angle)
		spawn_bullet(source, direction, scene_tree)
		await scene_tree.current_scene.get_tree().create_timer(0.1).timeout
