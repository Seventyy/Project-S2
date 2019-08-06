extends Area2D

class_name Player

export(float) var hp
onready var max_hp=hp
export(float) var body_damage

export(PackedScene) var projectile
var projectile_icon = load("res://graphics/player_projectile_icon_pea.png")

var velocity = Vector2()
var direction = Vector2()
var momentum = Vector2()

export var acceleration=10
export(float, 1) var friction=0.9

export var up_speed=500
export var side_speed=700
export var down_speed=900

const UP=Vector2(0,-1)
const DOWN=Vector2(0,1)
const LEFT=Vector2(-1,0)
const RIGHT=Vector2(1,0)

var shot_available=false
var weapons = ["weapon_pea", "weapon_pancake"]

func _ready():
	set_position(Vector2(get_viewport().size.x/2,get_viewport().size.y*0.90))

func applyMovement():
	
	direction=Vector2()
	
	if Input.is_key_pressed(KEY_W):
		direction+=UP
	if Input.is_key_pressed(KEY_S):
		direction+=DOWN
	if Input.is_key_pressed(KEY_A):
		direction+=LEFT
	if Input.is_key_pressed(KEY_D):
		direction+=RIGHT
	
	direction=direction.normalized()
	
	if direction.x!=0 and abs(velocity.x)<side_speed:
		velocity.x+=direction.x*side_speed/acceleration
	if direction.y<0 and abs(velocity.y)<up_speed:
		velocity.y+=direction.y*up_speed/acceleration
	if direction.y>0 and abs(velocity.y)<down_speed:
		velocity.y+=direction.y*down_speed/acceleration
	
	velocity*=friction 
	
#	if not (Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_D)):
#		velocity-=velocity.normalized()*friction
#		if velocity.length()<friction:
#			velocity=Vector2(0,0)


func shooting():
	if Input.is_action_just_pressed("Weapon_Change"):
		weapons.append(weapons[0])
		weapons.remove(0)
		if weapons[0] == "weapon_pea":
			projectile_icon=load("res://graphics/player_projectile_icon_pea.png")
		if weapons[0] == "weapon_pancake":
			projectile_icon=load("res://graphics/player_projectile_icon_wide.png")
		
	if shot_available and Input.is_key_pressed(KEY_SPACE):
		if projectile!=null:
			if weapons[0] == "weapon_pea":
				projectile=load("res://scenes/projectile_pea/projectile_pea.tscn")
			if weapons[0] == "weapon_pancake":
				projectile=load("res://scenes/projectile_wide/projectile_wide.tscn")
				projectile_icon=load("res://graphics/player_projectile_icon_wide.png")
			var projectile_unpacked=projectile.instance()
			projectile_unpacked.set_position(self.position)
			get_node("/root/Root").add_child(projectile_unpacked)
			shot_available=false
			get_node("FireRate").start()

func enableShot():
	shot_available=true
	get_node("FireRate").stop()

func stopOnScreenEdges():
	if position.x<0:
		position.x=0
		velocity.x=0
	if position.y<0:
		position.y=0
		velocity.y=0
	if position.x>1280:
		position.x=1280
		velocity.x=0
	if position.y>720:
		position.y=720
		velocity.y=0

func checkLife():
	if hp<=0:
		get_tree().queue_delete(self)
		get_tree().change_scene("res://scenes/death_screen/death_screen.tscn")

func _process(delta):
	checkLife()
	shooting()
	applyMovement()
	stopOnScreenEdges()
	translate(velocity*delta)

func onAreaEntered(area):
	if area is Projectile:
		if area.dmg_player:
			hp-=area.damage
			get_tree().queue_delete(area)
	elif area is Enemy:
		area.hp-=self.body_damage
		self.hp-=area.body_damage
	pass
