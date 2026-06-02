extends Area2D
@export var durability: int = 1
func _ready():
	area_entered.connect(_on_area_entered)
func _on_area_entered(area: Area2D):
	var phan_biet_dan = area.get("handle_enemy_bullet_animation")
	if phan_biet_dan != null:
		area.queue_free()
		durability -= 1
		if durability <= 0:
			queue_free()
