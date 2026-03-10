extends Area2D

var speed : float = 200
var damage : float = 1
var direction : Vector2
var source
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction*speed*delta
	
	if global_position.y > get_viewport_rect().size.y +1:
		queue_free()
	if global_position.y < -10:
		queue_free()
	if global_position.x > get_viewport_rect().size.x +1:
		queue_free()
	if global_position.x < -10:
		queue_free()
	
func _on_body_entered(body):
	if body.has_method("gold_take"):
			body.gold_take(damage)
			queue_free()
