extends Area2D

@export var stat : pick_up
@onready var animation = $AnimatedSprite2D
@onready var coligen = $Node2D
@onready var lable=$Label
@export var player_reference : CharacterBody2D:
	set(value):
		player_reference = value
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

func _on_body_entered(body : Node2D) -> void:
	if body == null :
		print("player not found")
		return
	player_reference = body
	
	if stat.type == stat.types.pick_up_card:
		activate()
	if stat.type != stat.types.pick_up_card:
		pick_up()

func pick_up():
	if player_reference:
		stat.upgrade_item(player_reference)
		queue_free()

func activate():
	var cards = stat.card_pool_in_game.cards.pick_random()
	cards.apply_card(player_reference)
	queue_free()

func tao_coligen():
	var texture = animation.sprite_frames.get_frame_texture(stat.animation, 0)
	var size = texture.get_size()
	var shape = RectangleShape2D.new()
	shape.size=size
	coligen.shape = shape
