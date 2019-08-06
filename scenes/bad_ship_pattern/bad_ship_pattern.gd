extends EnemyPattern

var current_target
export(Array) var target_list
var target_list_iterator=0

func move(delta):
	if target_list.size()>0:
		if velocity.length()<(velocity.normalized()*speed*delta).length():
			position=current_target
		if position==current_target:
			if target_list.size()>target_list_iterator+1:
				target_list_iterator+=1
			else:
				target_list_iterator=0
		current_target=target_list[target_list_iterator]
		velocity=current_target-position
	position+=velocity.normalized()*speed*delta