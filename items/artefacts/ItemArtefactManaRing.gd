extends "res://items/item_parent.gd"



func _process(delta):
	if Input.is_action_just_pressed("ui_accept") && get_overlapping_areas():
		ArtefactMenu.get_node("Artefacts1/Panel3").disabled = false
		ArtefactMenu.get_node("Artefacts2/Panel3").disabled = false
		ArtefactMenu.get_node("Artefacts3/Panel3").disabled = false
		ArtefactMenu.get_node("Artefacts4/Panel3").disabled = false
		
		ArtefactMenu.artefacts.artefacts_panel3_disabled = false
		ArtefactMenu.save_data()


func _on_Item_area_entered(area: Area2D) -> void:
	$PickText.visible = true

func _on_Item_area_exited(area: Area2D) -> void:
	$PickText.visible = false
