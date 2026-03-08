extends CharacterBody2D

var target_position : Vector2
var move_speed := 600
var is_entering := true
@export var player_reference : CharacterBody2D

var drop
var damage: float 
var health: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_entering:
		var dir = (target_position - global_position).normalized()
		velocity = dir * move_speed
		move_and_slide()

		if global_position.distance_to(target_position) < 5:
			global_position = target_position
			is_entering = false
			velocity = Vector2.ZERO
	
	if global_position.y > get_viewport_rect().size.y +1:
		print("xoa enemy")
		queue_free()
