extends TextureButton


var artefact_name = ""


func _on_Panel1_pressed() -> void:
	print(artefact_name, " : ", $"../..".artefacts.current_artefact1_artefact_name)
	if texture_normal != load("res://assets/HUD/artefacts/artefact_icon.png"):
		$"../../DesciptionContainer".update_description_artefact1()
