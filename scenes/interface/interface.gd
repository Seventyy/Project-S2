extends Control

func _process(delta):
	$CoinCounter.text=String(get_node("/root/Root/Player").picked_coins)
	$PlayerHpBar.max_value=get_node("/root/Root/Player").max_hp
	$PlayerHpBar.value=get_node("/root/Root/Player").hp
	$EquippedWeapon.texture=get_node("/root/Root/Player").projectile_icon