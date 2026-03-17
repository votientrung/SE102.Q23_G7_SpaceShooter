extends Resource

class_name Boss

@export var title : String
@export var texture : Texture2D
@export var frames : SpriteFrames

@export var damage : float
@export var health : float
@export var speed  : float
@export var bullet_speed : float
@export var firerate: float
@export var skills : Array[EnemySkill]
@export var phase_hp : Array[float]

@export var drop : int
@export var golddrop : int
@export var point : float
