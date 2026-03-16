extends CharacterBody2D


var current_phase := 0
var current_skill := 0
@export var player_reference : CharacterBody2D

var title : String
var texture : Texture2D
var frames : SpriteFrames

var damage : float
var health : float
var speed  : float
var bullet_speed : float
var skills : Array[EnemySkill]
var Skills_CD : Array[float]
var phase_hp : Array[float]

var drop : int
var golddrop : int
var point : float

var is_dead : bool
var target_position : Vector2
var is_entering : bool
var firerate : float
var wavecount: int

var type : Boss:
	set(value):
		type = value
		title = value.title
		$Sprite2D.texture = value.texture
		$AnimatedSprite2D.sprite_frames = value.frames
		
		damage = value.damage
		health = value.health
		speed  = value.speed
		bullet_speed = value.bullet_speed
		firerate = value.firerate
		skills = value.skills
		phase_hp = value.phase_hp
		
		golddrop = value.golddrop
		point = value.point
		

@onready var ray_cast = $RayCast2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	is_dead = false
	is_entering = true
	Skills_CD.resize(skills.size())
	for i in range(skills.size()):
		Skills_CD[i] = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_dead:
		return
	
	var detec = (player_reference.global_position - global_position).normalized()
	ray_cast.target_position = detec * 1000
	for i in range(skills.size()):
		Skills_CD[i] -= delta
	
	if global_position.distance_to(target_position) <5:
		target_position = choose_new_target()
	
	var dir = (target_position - global_position).normalized()
	velocity = dir * speed
	move_and_slide()
	
	if firerate <= 0 :
		use_random_skill()
		firerate = type.firerate
	firerate -= delta

func use_random_skill():
	if skills.size() == 0:
		return
	current_skill = randi() % skills.size()
	if Skills_CD[current_skill] <= 0 :
		skills[current_skill].skillcast(self, player_reference, get_tree())
		Skills_CD[current_skill] = skills[current_skill].cooldown
	

func damage_take(damage : float):
	health -= damage
	hit_flash()
	if health <=0 :
		is_dead = true


func choose_new_target() -> Vector2:
	var x = randf_range(100, get_viewport_rect().size.x-100)
	var y = randf_range(100, get_viewport_rect().size.y-400)
	return Vector2(x, y)


func hit_flash():
	$AnimatedSprite2D.modulate = Color(1,0.3,0.3)
	await get_tree().create_timer(0.1).timeout
	$AnimatedSprite2D.modulate = Color(1,1,1)

func check_phase():

	if current_phase >= phase_hp.size():
		return false

	if health <= phase_hp[current_phase]:

		current_phase += 1
		return true

	return false
