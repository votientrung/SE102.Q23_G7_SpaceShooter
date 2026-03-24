extends Area2D

@export var stat : pick_up
@onready var animation = $AnimatedSprite2D
@onready var coligen = $Node2D
func _ready() -> void:
	scale = stat.scale
	animation.sprite_frames = stat.frame
	animation.play(stat.animation)
	tao_coligen()
func _process(delta: float) -> void:
	position += stat.direction * stat.speed * delta
	
	if global_position.y > get_viewport_rect().size.y +1:
		queue_free()
	if global_position.y < -10:
		queue_free()
	if global_position.x > get_viewport_rect().size.x +1:
		queue_free()
	if global_position.x < -10:
		queue_free()

func _on_body_entered(body: CharacterBody2D) -> void:
	if body is CharacterBody2D:
		stat.apply(body)
		queue_free()
func tao_coligen():
	var texture = animation.sprite_frames.get_frame_texture(stat.animation, 0)
	var size = texture.get_size()
	var shape = RectangleShape2D.new()
	shape.size=size
	coligen.shape = shape
