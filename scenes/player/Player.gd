extends Area2D

class_name Player

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
	if shot_available and Input.is_key_pressed(KEY_SPACE):
		var projectile_scene=load("res://scenes/PlayerProjectile/PlayerProjectile.tscn")
		var projectile=projectile_scene.instance()
		projectile.set_position(self.position)
		self.owner.add_child(projectile)
		shot_available=false
		get_node("FireRate").start()

func enable_shot():
	shot_available=true
	get_node("FireRate").stop()

func stop_on_screen_edges():
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
		
func _process(delta):
	shooting()
	applyMovement()
	stop_on_screen_edges()
	translate(velocity*delta)