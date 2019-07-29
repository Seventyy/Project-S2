extends Area2D

class_name Projectile

export(float) var damage
export(float) var speed
export(Vector2) var velocity

export(bool) var dmg_player
export(bool) var dmg_enemies

func move(delta):
	position+=velocity.normalized()*speed*delta
	pass

func _process(delta):
	move(delta)
