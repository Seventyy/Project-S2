extends Area2D

class_name Enemy

enum MovementType {target_list,target_list_looped}

export(MovementType) var movement_type
export(float) var hp
export(float) var body_damage
export(float) var speed

export(Vector2) var target
export(Array) var target_array=[Vector2(100,100),Vector2(500,200),Vector2(1000,600),Vector2(1200,50)]
var target_array_iterator=0

var velocity=Vector2()

func move(delta):
	if target!=position:
		velocity=(target-position).normalized()*speed*delta
		if velocity.length()>(target-position).length():
			position=target
		else:
			position+=velocity
	else:
		if target_array_iterator<target_array.size()-1:
			target_array_iterator+=1
		else:
			target_array_iterator=0
		target=target_array[target_array_iterator]

func shoot():
	pass

func _process(delta):
	move(delta)