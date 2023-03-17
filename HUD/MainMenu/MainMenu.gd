extends CanvasLayer

onready var settingsmenu = load("res://ControlTest.tscn")


func _on_QuitGameButton_pressed():
	get_tree().quit()


func _on_OptionsButton_pressed() -> void:
	get_parent().add_child(settingsmenu.instance())
