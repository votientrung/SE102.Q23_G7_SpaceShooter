extends Node2D


var move_speed := 150
var direction := 1
var drop_distance := 40
var dropping = false
@export var start = false

func _ready() -> void:
	start = false
	dropping = false
	
func _process(delta):
	if start:
		global_position = Vector2.ZERO
		return
	
	if dropping:
		return
	global_position.x += move_speed * direction * delta

	var screen = get_viewport_rect().size

	for enemy in get_children():
		if enemy.global_position.x > screen.x - 50:
			start_drop(-1)
			break
		if enemy.global_position.x < 50:
			start_drop(1)
			break
	

func start_drop(new_direction):

	dropping = true

	var tween = create_tween()

	tween.tween_property(
		self,
		"position:y",
		position.y + drop_distance,
		0.3
	)

	await tween.finished

	direction = new_direction
	dropping = false
