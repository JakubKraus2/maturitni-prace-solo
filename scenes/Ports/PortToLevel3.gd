extends Area2D




func _on_PortToLevel3_area_entered(area: Area2D) -> void:
	get_tree().change_scene("res://scenes/DemoLevel3.tscn")
	SwordsMaster.position.x = 0
	LoadingScreen.get_node("AnimationPlayer").play("LOADING")
