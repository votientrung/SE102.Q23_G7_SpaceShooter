extends Node2D

class_name EnemySpawner

@export var enemy_scene : PackedScene
@export var player_scene : Area2D
var wave_pattern : WavePattern
@export var formation : Node2D
@export var horizontal_spacing := 40
@export var vertical_spacing := 40

@export var start_y := 40
@export var enemy_types : Array[Enemy]
@export var waves : Array[WavePattern]
func _ready():
		spawn_wave()

func _process(delta):
	if formation.get_child_count() == 0 and !formation.start:
		start_next_wave()

func spawn_wave():
	wave_pattern = waves.pick_random()
	var pattern = wave_pattern.pattern

	for y in range(pattern.size()):
		for x in range(pattern[y].size()):

			if pattern[y][x] == -1:
				continue
			var enemy = enemy_scene.instantiate()
			if enemy_types.size() == 0:
				print("No enemy types!")
				return
			enemy.type = enemy_types.pick_random()
			
			enemy.player_reference = player_scene
			
			var pos = Vector2(
				150 + x * horizontal_spacing,
				start_y + y * vertical_spacing
			)
			var spawn_pos = pos + Vector2(0,-200)
			enemy.global_position = spawn_pos
			enemy.target_position = formation.global_position + pos

			formation.add_child(enemy)


func start_next_wave():

	formation.start = true
	await get_tree().create_timer(0.3).timeout
	spawn_wave()
	formation.start = false
