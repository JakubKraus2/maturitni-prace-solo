extends ProgressBar


func _ready() -> void:
	max_value = get_parent().get_parent().hp
	value = get_parent().get_parent().hp
	$ProgressBar2.max_value = get_parent().get_parent().hp
	$ProgressBar2.value = get_parent().get_parent().hp

func _process(delta: float) -> void:
	$ProgressBar2.value = lerp($ProgressBar2.value, value, 0.1)
	if $ProgressBar2.value - value <= 0.5:
		$ProgressBar2.value = value
		set_process(false)

func set_bar_value(value_to_set):
	value = value_to_set
	$Timer.start()

func _on_Timer_timeout() -> void:
	set_process(true)
