extends FormationPattern
class_name SpiralFormationPattern

@export var center := Vector2(350, 350)

# tốc độ quay
@export var angular_speed := 4.0

# tốc độ spiral bung ra
@export var radius_speed := 55.0

# bán kính bắt đầu
@export var start_radius := 20.0

# thời gian bay vào tâm
@export var enter_duration := 2.0
@export var spiral_turns := 12.0

func get_position(time: float) -> Vector2:

	# =========================
	# 1. BAY VÀO TÂM
	# =========================
	if time < enter_duration:
		return center * (time / enter_duration)

	# =========================
	# 2. XOẮN ỐC
	# =========================
	var t = time - enter_duration

	var radius = start_radius + radius_speed * t

	# chiều kim đồng hồ
	var angle = -(t * spiral_turns) / sqrt(radius * 0.03)

	return center + Vector2(
		cos(angle),
		sin(angle)
	) * radius
