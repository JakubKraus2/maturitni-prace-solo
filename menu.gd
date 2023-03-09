extends Control

func _ready():
	$newGame.grab_focus()

func _on_newGame_pressed():
	get_tree().change_scene("res://scenes/Tester.tscn")


func _on_continue_pressed():
	get_tree().change_scene("res://scenes/Tester.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_settings_pressed():
	get_tree().change_scene("res://scenes/settings.tscn")


func _on_mute_pressed():
	pass # Replace with function body.
