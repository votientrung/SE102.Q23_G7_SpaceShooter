extends Resource
class_name pick_up

@export var frame : SpriteFrames
@export var animation : String = "default"
@export var type : types
@export var scale : Vector2 = Vector2(1,1)
@export var speed : float = 300
@export var direction : Vector2 = Vector2.DOWN
@export var stat : float = 1
@export var card_pool_in_game :card_pool
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

func apply(player):
	match type:
		types.weapon_change_to_default:
			player.switch_to_defaul()
		types.weapon_change_to_laze:
			player.switch_to_laze()
		types.weapon_change_to_snake:
			player.switch_to_snake()
		types.level_up:
			if player.stat.weapon_level < 3:
				player.stat.weapon_level +=1
		types.gold:
			print("you take ",stat," gold")
			player.gold += stat
		types.energy:
			print("you take ",stat," energy")
			player.energy += stat
		types.damage:
			player.stat.damage += stat
		types.def:
			player.defence += stat
		types.pick_up_card:
			var random_card = card_pool_in_game.cards.pick_random()
			CardManager.add_card(random_card)
