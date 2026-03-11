extends CharacterBody2D

var target_position : Vector2
var move_speed := 600
var is_entering := true
@export var player_reference : CharacterBody2D

var drop
var damage: float 
var health: float
var golddrop : int
var point : float
@export var wave_count :int =0
var skill : EnemySkill
var CD : float =0

var type : Enemy:
	set(value):
		type = value
		$Sprite2D.texture = value.texture
		damage = value.damage
		health = value.health
		golddrop = value.golddrop
		point = value.point
		skill = value.skill


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#enter
	if is_entering:
		var dir = (target_position - global_position).normalized()
		velocity = dir * move_speed
		move_and_slide()

		if global_position.distance_to(target_position) < 5:
			global_position = target_position
			is_entering = false
			velocity = Vector2.ZERO
	
	#skill
	if skill != null and !is_entering:
		CD -= delta
		var temp : int = randi() % 1000
		if CD <= 0 and temp < 50:
			skill.skillcast(self, player_reference, get_tree())
			CD = skill.cooldown
	
	# pass camera
	if global_position.y > get_viewport_rect().size.y +1:
		queue_free()
		




	


func damage_take(damage : float):
	health -= damage
	if health <= 0:
		queue_free()


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body.has_method("gold_take"):
			body.gold_take(damage)
			print("hit")
