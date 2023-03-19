extends CanvasLayer


func go_to_main_menu():
	get_tree().change_scene("res://HUD/MainMenu/MainMenu.tscn")
	$TextureRect.modulate = Color(1, 1, 1)
