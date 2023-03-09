extends Area2D



func _process(delta):
	if Input.is_action_just_pressed("ui_accept") && get_overlapping_areas():
		SpecialSkillMenu.visible = true


func _on_SpecialAttacksMonument_area_entered(area):
	$PickText.visible = true

func _on_SpecialAttacksMonument_area_exited(area):
	$PickText.visible = false
	SpecialSkillMenu.visible = false
