extends Particles2D



func _on_RemoveTimer_timeout():
	queue_free()
