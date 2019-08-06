extends Area2D

class_name Enemy

export(float) var hp=1
onready var max_hp=hp
export(float) var body_damage=0

export(float) var speed
export(Vector2) var velocity

export(PackedScene) var projectile

export(bool) var sprite_color_modulation=true
var color_modulation=Color(1,1,1)

func move(delta):
	position+=velocity.normalized()*speed*delta

func modulateSprite():
	if sprite_color_modulation:
		color_modulation=Color(1,hp/max_hp,hp/max_hp)
		for i in get_child_count():
			if get_child(i) is Sprite:
				get_child(i).modulate=color_modulation
		pass

func checkLife():
	if hp<=0:
		get_tree().queue_delete(self)

func _process(delta):
	modulateSprite()
	checkLife()
	move(delta)

func shoot():
	if projectile!=null:
		var projectile_unpacked=projectile.instance()
		if projectile_unpacked is Projectile:
			projectile_unpacked.transform=get_global_transform()
			get_node("/root/Root").add_child(projectile_unpacked)

func onAreaEntered(area):
	if area is Projectile:
		if area.dmg_enemies:
			hp-=area.damage
			get_tree().queue_delete(area)
