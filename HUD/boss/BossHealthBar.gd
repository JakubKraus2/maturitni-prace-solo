extends CanvasLayer


func _ready() -> void:
	$BossName.text = get_parent().boss_name

func _process(delta: float) -> void:
	if PlayerBasicData.current_lives <= 0:
		visible = false
		$ProgressBar.set_process(true)
		$ProgressBar.value = $ProgressBar.max_value
		$ProgressBar/ProgressBar2.value = $ProgressBar.max_value
