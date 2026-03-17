extends State
class_name BossAttack



func enter():
	super.enter()
	owner.set_physics_process(true)


func transition():
	if owner.check_phase :
		get_parent().change_state("PhaseChange")
	if owner.is_dead:
		get_parent().change_state("Death")
