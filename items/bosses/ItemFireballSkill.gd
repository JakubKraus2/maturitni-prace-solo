extends "res://items/item_parent.gd"



func _process(delta):
	if Input.is_action_just_pressed("ui_accept") && get_overlapping_areas():
		SpecialSkillMenu.get_node("Skills1/Panel2").disabled = false
		SpecialSkillMenu.get_node("Skills2/Panel2").disabled = false
		SpecialSkillMenu.get_node("Skills3/Panel2").disabled = false
		
		SpecialSkillMenu.skills.skills_panel2_disabled = false
		SpecialSkillMenu.save_data()
		
		save_player_data()


func _on_Item_area_entered(area: Area2D) -> void:
	$PickText.visible = true

func _on_Item_area_exited(area: Area2D) -> void:
	$PickText.visible = false
