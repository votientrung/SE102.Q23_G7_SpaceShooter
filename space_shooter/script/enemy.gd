extends CharacterBody2D

var target_position : Vector2
var move_speed := 600
var is_entering := true
var is_dead := false
@export var player_reference : CharacterBody2D
@export var pick_up_sence : PackedScene
@export var drop_list_weapon : Array[pick_up] = []
@export var drop_list_gold_and_energy : Array[pick_up] = []
@export var drop_list_stat : Array[pick_up] = []
var drop
var damage: float 
var health: float
var golddrop : int
var point : float
var wavecount :int 

var skill : EnemySkill
var CD : float =0
var bullet_speed : float
var type : Enemy:
	set(value):
		type = value
		$Sprite2D.texture = value.texture
		$AnimatedSprite2D.sprite_frames = value.frames
		damage = value.damage
		health = value.health
		golddrop = value.golddrop
		point = value.point
		skill = value.skill
		bullet_speed = value.bullet_speed


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# de goi bien ngau nhien 
	randomize()
	
	is_dead = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_dead :
		return
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
	hit_flash()
	if health <= 0:
		die()


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body.has_method("gold_take"):
			body.gold_take(damage)
			print("hit")

func hit_flash():
	$AnimatedSprite2D.modulate = Color(1,0.3,0.3)
	await get_tree().create_timer(0.1).timeout
	$AnimatedSprite2D.modulate = Color(1,1,1)

func die():
	if is_dead:
		return
	is_dead = true
	$Sprite2D.visible = false
	$AnimatedSprite2D.play("die")
	drop_item()
	await $AnimatedSprite2D.animation_finished
	$AnimatedSprite2D.visible = false
	queue_free()

# ham drop item
func drop_item():
	# var random nay la bien ngau nhien giao dong tu 0 -> 1
	var random = randf()
	# ti le de rot do la 10%
	if random <0.1 :
		var item = pick_up_sence.instantiate()
		item.global_position = global_position
		item.stat = drop_list_weapon.pick_random()
		get_tree().current_scene.add_child(item)
	elif random <0.4:
		var item = pick_up_sence.instantiate()
		item.global_position = global_position
		item.stat = drop_list_gold_and_energy.pick_random()
		get_tree().current_scene.add_child(item)
	elif random <0.7:
		var item = pick_up_sence.instantiate()
		item.global_position = global_position
		item.stat = drop_list_stat.pick_random()
		get_tree().current_scene.add_child(item)
	else :
		return
