extends Sprite

export(float, 5000) var layer_speed
var parallax = Vector2()

func _ready():
	parallax.y=-get_rect().size.y+720

func _process(delta):
	parallax.y+=layer_speed*delta
	set_offset(parallax)
	if parallax.y > 720:
		parallax.y=-get_rect().size.y+720