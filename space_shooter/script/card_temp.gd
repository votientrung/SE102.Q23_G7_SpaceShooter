extends Area2D
class_name card_in_game
@export var stat : card
@onready var picture = $Sprite2D
@onready var coligen = $Area2D/CollisionShape2D

func _ready() -> void:
	tao_coligen()

func tao_coligen():
	var texture = stat.image
	var size = texture.get_size()
	var shape = RectangleShape2D.new()
	shape.size=size
	coligen.shape = shape
