extends TextureProgress

var mana_upgrade = 0
var mana_ring = 1

func _ready() -> void:
	max_value = PlayerBasicData.max_mana * mana_ring
	value = PlayerBasicData.current_mana * mana_ring
	$ManaBar2.max_value = PlayerBasicData.max_mana * mana_ring
	$ManaBar2.value = PlayerBasicData.current_mana * mana_ring

func _process(delta):
	$ManaBar2.value = lerp($ManaBar2.value, value, 0.1)
	if $ManaBar2.value - value <= 0.5:
		$ManaBar2.value = value
		set_process(false)

func set_bar_value(value_to_set):
	value = value_to_set
	$Timer.start()

func _on_Timer_timeout() -> void:
	set_process(true)

func upgrade_mana(mana_upgrade):
	max_value = PlayerBasicData.max_mana + mana_upgrade
	$ManaBar2.max_value = PlayerBasicData.max_mana + mana_upgrade
	PlayerBasicData.max_mana = max_value

func set_to_max():
	max_value = PlayerBasicData.max_mana * mana_ring
	value = PlayerBasicData.max_mana * mana_ring
	$ManaBar2.max_value = PlayerBasicData.max_mana * mana_ring
	$ManaBar2.value = PlayerBasicData.max_mana * mana_ring
