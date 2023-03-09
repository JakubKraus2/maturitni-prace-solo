extends Camera2D


func _on_SwordsMaster_grounded_updated(is_grounded) -> void:
	drag_margin_v_enabled = !is_grounded
