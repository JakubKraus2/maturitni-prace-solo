extends TextureButton



func _on_OkButton_pressed() -> void:
	get_parent().visible = false
	CheckpointMenu.visible = true
