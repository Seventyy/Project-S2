tool
extends Area2D

class_name Enemy

export(Shape2D) var collision_shape setget setCollision
export(Texture) var texture setget setTexture

func setCollision(new_collision):
	collision_shape=new_collision
	$CollisionShape2D.set_shape(collision_shape)

func setTexture(new_texture):
	texture=new_texture
	$Sprite.set_texture(texture)

