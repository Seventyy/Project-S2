extends Area2D

class_name Enemy

export(float) var hp
onready var max_hp=hp
export(float) var body_damage

export(int,0,500) var coin_amount
export(float) var speed
export(Vector2) var velocity

export(PackedScene) var projectile

var rand=RandomNumberGenerator.new()

export(bool) var sprite_color_modulation=true
var color_modulation=Color(1,1,1)

var coin

func pickupExplosion():
	for i in range(coin_amount):
		rand.randomize()
		coin=load("res://scenes/pickup_coin/pickup_coin.tscn")
		var coin_unpacked=coin.instance()
		coin_unpacked.transform=get_global_transform()
		get_node("/root/Root").add_child(coin_unpacked)
		coin_unpacked.apply_central_impulse(Vector2(rand.randi_range(-64,64),rand.randi_range(-64,64)).normalized()*rand.randi_range(0,500))

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

func modulateSprite():
	if sprite_color_modulation==true:
		color_modulation=Color(1,hp/max_hp,hp/max_hp)
		for i in get_child_count():
			if get_child(i) is Sprite:
				get_child(i).modulate=color_modulation
		pass

func checkLife():
	if hp<=0:
		pickupExplosion()
		target_list.clear()
		queue_free()

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