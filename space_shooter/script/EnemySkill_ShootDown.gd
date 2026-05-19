extends enemyskill


func skillcast(source, target, scence_tree):
	shoot(source, target, scence_tree)

func shoot(source, target, scene_tree):
	var bullet = enenmy_bullet.instantiate()
	bullet.source = source
	bullet.global_position  = source.global_position 
	bullet.damage = source.damage
	bullet.direction = Vector2.DOWN
	scene_tree.current_scene.add_child(bullet)
	print("fire")
