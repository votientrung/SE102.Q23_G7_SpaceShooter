extends Item
class_name PassiveItem

@export var upgrades : Array[stats]
var player_reference

func is_upgradable() -> bool:
	if level <= upgrades.size():
		return true
	return false

func upgrade_item():
	if  not is_upgradable():
		print("can not upgrade")
		return
	
	if player_reference == null:
		print("player not found")
		return
	
	var upgrade = upgrades[level-1]
	player_reference.gold=upgrade.gold
	player_reference.mana=upgrade.mana
	player_reference.gold_regent=upgrade.gold_regent
	player_reference.mana_regent=upgrade.mana_regent
	player_reference.gold_modified=upgrade.gold_modified
	player_reference.mana_modified=upgrade.mana_modified
	player_reference.armor=upgrade.armor
	player_reference.damage=upgrade.damage
	player_reference.damage_modified=upgrade.damage_modified
	player_reference.might=upgrade.might
	player_reference.scale_bullet=upgrade.scale_bullet
	player_reference.speed=upgrade.speed
	player_reference.luck=upgrade.luck
	
	level +=1
