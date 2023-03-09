extends CanvasLayer



func _on_SkillsButton_pressed() -> void:
	visible = false
	SpecialSkillMenu.visible = true


func _on_LeaveButton_pressed() -> void:
	visible = false
	SwordsMaster.attacking = false
	SwordsMaster.can_dash = true


func _on_StatusButton_pressed() -> void:
	visible = false
	StatusMenu.update_stats()
	StatusMenu.visible = true


func _on_ArtefactsButton_pressed() -> void:
	visible = false
	ArtefactMenu.visible = true
