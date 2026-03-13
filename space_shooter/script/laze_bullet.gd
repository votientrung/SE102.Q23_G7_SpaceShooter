extends Area2D
class_name lazes

@onready var handle_player_laze_animation= $AnimatedSprite2D
@export var damage : float = 1

func  _ready():
	visible = false

func activate_laze():
	visible = true
	handle_animation()

func deactivate_laze():
	visible = false

func _process(delta):
	# ngan ko cho tat beam ma van gay dmg
	if visible == false:
		return
	
	# handle animation
	handle_animation()
	
	# gay dmg theo delta
	for body in get_overlapping_bodies():
		if body.has_method("damage_take"):
			body.damage_take(1 * delta)
	
	

func laze_charge(time_charge):
	scale = Vector2(time_charge * 10,1)
	damage = time_charge * 5
	handle_animation()

func laze_charge_end():
	damage=1
	global_scale=Vector2(1,1)

func handle_animation():
	handle_player_laze_animation.play("default")
