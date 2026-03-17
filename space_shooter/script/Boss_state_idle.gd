extends State
class_name BossIdle


func transition():
	if ray_cast.is_colliding():
		get_parent().change_state("Attack")
