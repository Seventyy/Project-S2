extends Area2D

func _process(delta):
	emit_signal("body_entered")
