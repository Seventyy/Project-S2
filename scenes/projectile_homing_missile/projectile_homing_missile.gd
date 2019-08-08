extends Projectile

func move(delta):
	var player_pos=get_node("/root/Root/Player").position
	var vec2player=player_pos-self.position
	velocity=vec2player
	look_at(player_pos)
	position+=velocity.normalized()*speed*delta