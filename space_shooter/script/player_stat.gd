extends Resource
class_name stats
@export var gold : float = 1000
@export var mana : float = 12
# hoi mana va gold moi giay neu muon
@export var gold_regent : float = 0
@export var mana_regent : float = 0
@export var gold_modified : float = 1.0
@export var mana_modified : float = 1.0
@export var armor : float = 0

@export var damage : float = 1
@export var damage_modified : float = 1.0
# he so crit sat thuong 1.0 = 100% , 1.5 = 150%
@export var might : float = 1.0
# do bu cua don danh
@export var scale_bullet : float = 1.0
@export var speed : float = 300
# he so may man anh huong den ti le rot do 
@export var luck : float = -10

@export var weapon_lv : float = 0
@export var weapon_current : float = 0
