extends Area2D
class_name lazes

@onready var handle_player_laze_animation= $AnimatedSprite2D
@export var damage : float 

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
			body.damage_take(damage)
			print(damage)
	
	

func laze_charge(time_charge : float , damage_charge :float):
	scale = Vector2(pow(1.5,time_charge),1)
	damage = damage_charge
	handle_animation()

func laze_charge_end(original_damage : float):
	damage=original_damage
	global_scale=Vector2(1,1)

func handle_animation():
	handle_player_laze_animation.play("default")
