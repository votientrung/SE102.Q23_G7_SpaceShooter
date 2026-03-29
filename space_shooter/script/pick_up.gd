extends Resource
class_name pick_up

@export var frame : SpriteFrames
@export var animation : String = "default"
@export var type : types
@export var scale : Vector2 = Vector2(1,1)
@export var speed : float = 300
@export var direction : Vector2 = Vector2.DOWN
@export var upgrade : stats
@export var card_pool_in_game :card_pool
var player_reference

enum types {
	gold,
	energy,
	weapon_change_to_default,
	weapon_change_to_laze,
	weapon_change_to_snake,
	pick_up_card,
	unique_card,
	level_up,
	damage,
	def
}
func upgrade_item(player_reference):
	if player_reference == null:
		print("player not found")
		return
	
	player_reference.gold+=upgrade.gold
	player_reference.mana+=upgrade.mana
	player_reference.gold_regent+=upgrade.gold_regent
	player_reference.mana_regent+=upgrade.mana_regent
	player_reference.gold_modified+=upgrade.gold_modified
	player_reference.mana_modified+=upgrade.mana_modified
	player_reference.armor+=upgrade.armor
	player_reference.damage+=upgrade.damage
	player_reference.damage_modified+=upgrade.damage_modified
	player_reference.might+=upgrade.might
	player_reference.scale_bullet+=upgrade.scale_bullet
	player_reference.speed+=upgrade.speed
	player_reference.luck+=upgrade.luck
	player_reference.weapon_lv += upgrade.weapon_lv
	player_reference.weapon_current = upgrade.weapon_current


func pick_up_card():
	var random_card = card_pool_in_game.cards.pick_random()
	CardManager.add_card(random_card)
