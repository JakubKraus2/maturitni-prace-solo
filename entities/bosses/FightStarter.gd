extends Area2D




func _on_FightStarter_area_entered(area: Area2D) -> void:
	get_parent().start()