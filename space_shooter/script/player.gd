extends CharacterBody2D
@onready var collistion_rect:CollisionShape2D = $CollisionShape2D

@onready var default = $weapon_default
@onready var laze = $weapon_laze

@onready var weapons_array = [default,laze]
var current_weapon_index = 0
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
var gold: float = 1000

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
	
	default.activate()
	laze.deactivate()


func _process(delta):
	# lay vi tri chuot
	var mouse_pos = get_global_mouse_position()
	# charater bondry
	mouse_pos.x = clamp(mouse_pos.x, start_bound_x + bound_size_x * transform.get_scale().x
	,end_bound_x - bound_size_x * transform.get_scale().x)
	mouse_pos.y = clamp(mouse_pos.y, start_bound_y + bound_size_y * transform.get_scale().y
	, end_bound_y - bound_size_y * transform.get_scale().y)
	
	position = mouse_pos
	
	#die
	if gold < 0:
		die()

var switch_weapon_delay = 5
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("switch"):
		weapons_array[current_weapon_index].deactivate()
		current_weapon_index = current_weapon_index + 1
		if current_weapon_index >= weapons_array.size():
			current_weapon_index = 0
		weapons_array[current_weapon_index].activate()

#take dam
func gold_take(damage):
	print("take dmg")
	print("dmg " , damage)
	gold -= damage
	print("gold left " , gold)

func die():
	queue_free()
