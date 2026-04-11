extends activate_card
class_name shield_card
@export var shield_scene: PackedScene
func use_card(player):
	var existing_shield = player.get_node_or_null("PlayerShield")
	if existing_shield:
		existing_shield.durability += 1
	else:
		var shield_instance = shield_scene.instantiate()
		shield_instance.name = "PlayerShield"
		player.add_child(shield_instance)
