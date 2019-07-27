extends Area2D

class_name Enemy

export(float) var hp
export(float) var speed
export(Vector2) var velocity

func move():
	pass

func shoot():
	pass

func _process(delta):
	move()