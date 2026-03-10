extends Area2D

func _on_area_entered(area) :
	if area is bullets and not area.is_queued_for_deletion():
		print(area.get_path())
		area.queue_free()
