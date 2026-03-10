extends Area2D
@onready var collistion_rect:CollisionShape2D = $CollisionShape2D
@onready var weapon =$weapon
#bound size
var bound_size_x
var bound_size_y
var start_bound_x
var end_bound_x
var start_bound_y
var end_bound_y

#player stat
var damage: float = 1
var defence: float = 1
var gold: float = 10

# setting camera
func _ready() -> void:
	bound_size_x = collistion_rect.shape.get_rect().size.x
	bound_size_y = collistion_rect.shape.get_rect().size.y
	var rect = get_viewport().get_visible_rect()
	var camera = get_viewport().get_camera_2d()
	var camera_position =camera.position
	start_bound_x = camera_position.x- (rect.size.x)/2
	end_bound_x = camera_position.x + (rect.size.x)/2
	start_bound_y = camera_position.y - (rect.size.y)/2
	end_bound_y = camera_position.y + (rect.size.y)/2

var fire_rate =0.2
var fire_delta =0
func _process(delta):
	# lay vi tri chuot
	var mouse_pos = get_global_mouse_position()
	# charater bondry
	mouse_pos.x = clamp(mouse_pos.x, start_bound_x + bound_size_x * transform.get_scale().x
	,end_bound_x - bound_size_x * transform.get_scale().x)
	mouse_pos.y = clamp(mouse_pos.y, start_bound_y + bound_size_y * transform.get_scale().y
	, end_bound_y - bound_size_y * transform.get_scale().y)
	
	position = mouse_pos
	
	fire_delta=fire_delta-delta
	if Input.is_action_pressed("shot") and fire_delta <=0 :
		weapon.weapon_shot()
		fire_delta=fire_rate


var can_shot = true
func _input(event):
	#player shoting
	if event.is_action_pressed("shot") and can_shot:
		can_shot = false
		weapon.weapon_shot()
		await get_tree().create_timer(0.1).timeout
		can_shot = true

func gold_take(damage):
	gold -= damage
	if gold <= 0:
		die()

func die():
	queue_free()
