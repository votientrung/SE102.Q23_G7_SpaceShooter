extends Area2D
class_name snakes
@onready var handle_player_bullet_animation= $AnimatedSprite2D
@export var damage : float 
@export var speed : float 
@export var direction : Vector2
@export var fire = false
func _process(delta): 
	# run animation 
	handle_animation()
	# di chuyen dan 
	if Input.is_action_just_pressed("move_bullet_down"):
		direction =Vector2.DOWN
	if Input.is_action_just_pressed("move_bullet_left"):
		direction =Vector2.LEFT
	if Input.is_action_just_pressed("move_bullet_right"):
		direction=Vector2.RIGHT
	if Input.is_action_just_pressed("move_bullet_up"):
		direction=Vector2.UP
	if fire == true :
		position += direction*speed*delta
	# remove bullet from scene
	if global_position.y > get_viewport_rect().size.y +1:
		queue_free()
	if global_position.y < -10:
		queue_free()
	if global_position.x > get_viewport_rect().size.x +1:
		queue_free()
	if global_position.x < -10:
		queue_free()

func explode(snake_bullet_size):
	scale = Vector2(snake_bullet_size+1,snake_bullet_size+1)
	fire =false
	direction =Vector2.ZERO
	damage=damage*10
	await get_tree().create_timer(0.3).timeout
	queue_free()



func _on_body_entered(body: CharacterBody2D) -> void:
	if body.has_method("damage_take") :
			body.damage_take(damage)


func handle_animation():
	handle_player_bullet_animation.play("default")
