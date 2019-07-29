extends Area2D

class_name Enemy

export(float) var hp
export(float) var speed
export(float) var body_damage
export(Vector2) var velocity

export(PackedScene) var projectile

func move(delta):
	position+=velocity.normalized()*speed*delta

func checkLife():
	if hp<=0:
		get_tree().queue_delete(self)

func _process(delta):
	checkLife()
	move(delta)

func shoot():
	if projectile!=null:
		var projectile_unpacked=projectile.instance()
		if projectile_unpacked is Projectile:
			projectile_unpacked.position=self.position
			owner.add_child(projectile_unpacked)

func onAreaCollision(area):
	if area is Projectile:
		if area.dmg_enemies:
			hp-=area.damage
			get_tree().queue_delete(area)

