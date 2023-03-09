extends TextureButton



func _on_OkButton_pressed() -> void:
	get_parent().visible = false
	CheckpointMenu.visible = true
	$"..".artefacts.current_artefact1_artefact_name = $"../CurrentArtefacts/Panel1".artefact_name
	$"..".artefacts.current_artefact1_texture_normal = $"../CurrentArtefacts/Panel1".texture_normal.resource_path
	$"..".artefacts.current_artefact1_texture_pressed = $"../CurrentArtefacts/Panel1".texture_pressed.resource_path
	
	$"..".artefacts.current_artefact2_artefact_name = $"../CurrentArtefacts/Panel2".artefact_name
	$"..".artefacts.current_artefact2_texture_normal = $"../CurrentArtefacts/Panel2".texture_normal.resource_path
	$"..".artefacts.current_artefact2_texture_pressed = $"../CurrentArtefacts/Panel2".texture_pressed.resource_path
	
	$"..".artefacts.current_artefact3_artefact_name = $"../CurrentArtefacts/Panel3".artefact_name
	$"..".artefacts.current_artefact3_texture_normal = $"../CurrentArtefacts/Panel3".texture_normal.resource_path
	$"..".artefacts.current_artefact3_texture_pressed = $"../CurrentArtefacts/Panel3".texture_pressed.resource_path
	
	$"..".artefacts.current_artefact4_artefact_name = $"../CurrentArtefacts/Panel4".artefact_name
	$"..".artefacts.current_artefact4_texture_normal = $"../CurrentArtefacts/Panel4".texture_normal.resource_path
	$"..".artefacts.current_artefact4_texture_pressed = $"../CurrentArtefacts/Panel4".texture_pressed.resource_path
	$"..".save_data()
	
	for i in $"../Artefacts1".get_child_count():
		$"../Artefacts1".get_child(i).boost()
