extends TextureButton


var artefact_name = ""


func _on_Panel3_pressed() -> void:
	print(artefact_name, " : ", $"../..".artefacts.current_artefact3_artefact_name)
	if texture_normal != load("res://assets/HUD/artefacts/artefact_icon.png") && $"../..".artefact3_group.get_pressed_button() != null:
		$"../../DesciptionContainer".update_description_artefact3()
