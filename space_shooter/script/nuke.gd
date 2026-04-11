extends activate_card
class_name nuke_card
@export var explosion_scene: PackedScene
func use_card(player):
	var explosion = explosion_scene.instantiate()
	player.get_parent().add_child(explosion)
	explosion.global_position = player.get_viewport_rect().size / 2
