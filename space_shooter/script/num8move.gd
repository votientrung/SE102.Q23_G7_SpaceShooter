extends FormationPattern
class_name Figure8FormationPattern

@export var speed := 1.5
@export var size := 400
@export var enter_duration := 2.0
@export var drop_speed := 250
@export var center := Vector2(300, 200)

func get_position(time: float) -> Vector2:
	if time < enter_duration:
		# bay từ (0,0) tới giữa
		return center * (time / enter_duration)

	elif time < enter_duration + 6.0:
		var t = time - enter_duration
		return Vector2(
			sin(t * speed) * size,
			sin(t * speed) * cos(t * speed) * size * 0.7 # bóp nhẹ chiều dọc cho đẹp
		) + center

	else:
		var t = time - (enter_duration + 6.0)
		return center + Vector2(0, t * drop_speed)
