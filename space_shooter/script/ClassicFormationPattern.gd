extends FormationPattern
class_name ClassicFormationPattern

@export var speed := 200
@export var drop_distance := 40
@export var screen_width := 1200

var direction := 1
var current_x := 0.0
var current_y := 0.0
var dropping := false

func get_position(time: float) -> Vector2:
	if time == 0:
		direction = 1
		current_x = 0.0
		current_y = 0.0
		drop_distance = 40

	if dropping:
		current_y += speed * 0.02
	else:
		current_x += speed * direction * 0.02

	if not dropping and (current_x < 0 or current_x > screen_width-500 ):
		direction *= -1
		dropping = true

	if dropping and current_y >= drop_distance:
		drop_distance+= 40
		dropping = false

	return Vector2(current_x, current_y)
