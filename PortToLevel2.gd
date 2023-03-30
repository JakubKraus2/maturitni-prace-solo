extends Area2D




func _on_PortToLevel2_area_entered(area: Area2D) -> void:
	get_tree().change_scene("res://scenes/DemoLevel2.tscn")
	SwordsMaster.position.x = 0
	LoadingScreen.get_node("AnimationPlayer").play("LOADING")
