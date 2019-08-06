extends Area2D

class_name Projectile

export(float, 0) var damage
export(float, 0) var speed
export(float, 0) var screenshake_scale
export(float, 0) var screenshake_time
export(int, "quadratic", "linear") var screenshake_type
export(Vector2) var velocity

export(bool) var dmg_player
export(bool) var dmg_enemies

func _ready():
	screenshake.start(screenshake_scale,screenshake_time,screenshake_type)

func vanishOnExitedScreen():
	if position.x<-1280 or position.y<-720 or position.x>2560 or position.y>1440:
		queue_free()

func move(delta):
	position+=velocity.normalized()*speed*delta
	pass

func _process(delta):
	move(delta)
	vanishOnExitedScreen()