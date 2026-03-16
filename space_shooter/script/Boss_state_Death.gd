extends State
class_name BossDeath

func enter():
	owner.is_dead = true
	$"../../Sprite2D".visible = false
	$"../../AnimatedSprite2D".play("die")
	await $"../../AnimatedSprite2D".animation_finished
	$"../../AnimatedSprite2D".visible = false
	owner.queue_free()
