extends Camera2D


func _process(delta: float) -> void:
	if Input.is_action_pressed("attack2"):
		current = true
		boss_cutscene()

func boss_cutscene():
	global_position.x = get_parent().position.x
