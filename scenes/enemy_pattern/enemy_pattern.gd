extends Enemy

class_name EnemyPattern

func checkLife():
	if get_child_count()==0:
		get_tree().queue_delete(self)

func modulateSprite():
	pass

func _process(delta):
	checkLife()
	move(delta)
