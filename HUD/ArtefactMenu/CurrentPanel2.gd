extends TextureButton


var artefact_name = ""


func _on_Panel2_pressed() -> void:
	print(artefact_name, " : ", $"../..".artefacts.current_artefact2_artefact_name)
	if texture_normal != load("res://assets/HUD/artefacts/artefact_icon.png") && $"../..".artefact2_group.get_pressed_button() != null:
		$"../../DesciptionContainer".update_description_artefact2()
