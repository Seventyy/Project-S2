extends Node2D

export(Texture) var texture
export(float) var layer_speed

func _ready():
	get_node("PralaxLayerBase").texture=self.texture
	get_node("PralaxLayerMirror").texture=self.texture
	get_node("PralaxLayerBase").layer_speed=self.layer_speed
	get_node("PralaxLayerMirror").layer_speed=self.layer_speed