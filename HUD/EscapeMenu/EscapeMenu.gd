extends CanvasLayer



func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel") && !visible:
		$AnimationPlayer.play("OPEN")
	elif Input.is_action_just_pressed("ui_cancel") && visible:
		$AnimationPlayer.play("CLOSE")


func _on_ContinueButton_pressed() -> void:
	$AnimationPlayer.play("CLOSE")

func _on_QuitToMenuButton_pressed() -> void:
	get_tree().quit()
