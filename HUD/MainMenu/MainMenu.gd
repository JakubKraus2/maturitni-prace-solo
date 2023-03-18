extends CanvasLayer


onready var settingsmenu = load("res://ControlTest.tscn")


func _ready() -> void:
	$Node2D/MainContainer/ButtonsCenterContainer/Buttons/LoadGameButton.disabled = false if SaveFile.game_data.current_scene != "" else true


func _on_QuitGameButton_pressed():
	get_tree().quit()


func _on_OptionsButton_pressed() -> void:
	get_parent().add_child(settingsmenu.instance())


func _on_LoadGameButton_pressed() -> void:
	if SaveFile.game_data.current_scene != "":
		SwordsMaster.velocity.y = 0
		SwordsMaster.velocity.x = 0
		SwordsMaster.global_position.x = SaveFile.game_data.positionx
		SwordsMaster.global_position.y = SaveFile.game_data.positiony
		get_tree().change_scene(SaveFile.game_data.current_scene)
