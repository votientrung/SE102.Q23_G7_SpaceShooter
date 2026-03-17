extends State
class_name BossChangePhase

func transition():
	if ray_cast.is_colliding():
		get_parent().change_state("Attack")

func enter():
	super.enter()
	owner.set_physics_process(true)
