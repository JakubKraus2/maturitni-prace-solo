extends CanvasLayer

onready var settingsmenu = load("res://ControlTest.tscn")


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel") && !visible:
		$AnimationPlayer.play("OPEN")
	elif Input.is_action_just_pressed("ui_cancel") && visible:
		$AnimationPlayer.play("CLOSE")


func _on_ContinueButton_pressed() -> void:
	$AnimationPlayer.play("CLOSE")

func _on_QuitToMenuButton_pressed() -> void:
	get_tree().change_scene("res://HUD/MainMenu/MainMenu.tscn")


func _on_OptionsButton_pressed() -> void:
	get_parent().add_child(settingsmenu.instance())
