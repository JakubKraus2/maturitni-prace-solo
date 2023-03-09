extends Particles2D



func _on_DeleteTimer_timeout() -> void:
	queue_free()
