extends Node2D


var move_speed := 150
var direction := 1
var drop_distance := 40
var dropping = false
@export var start = false

@export var pattern_lib : Array[FormationPattern]
var pattern: FormationPattern
var time := 0.0

func _ready() -> void:
	start = false
	dropping = false
	pattern = pattern_lib.pick_random()
	
func _process(delta):
	if start:
		time = 0.0
		pattern = pattern_lib.pick_random()
		return
	else:
		global_position = pattern.get_position(time)
		time += delta
	

func reset():

	var tween = create_tween()
	tween.tween_property(
		self,
		'global_position',
		Vector2.ZERO,
		0.2
	)
	await tween.finished
