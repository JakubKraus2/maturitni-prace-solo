extends GridContainer



func check_for_same_artefacts():
	for i in get_child_count():
		for j in get_child_count():
			if get_child(i).artefact_name == get_child(j).artefact_name && i != j && get_child(i).artefact_name != "":
				get_child(j).artefact_name = ""
				get_child(j).texture_normal = load("res://assets/HUD/artefacts/artefact_icon.png")
				get_child(j).texture_pressed = load("res://assets/HUD/artefacts/artefact_icon_pressed.png")
