extends Control

func _process(delta):
	$PlayerHpBar.max_value=owner.get_node("Player").max_hp
	$PlayerHpBar.value=owner.get_node("Player").hp