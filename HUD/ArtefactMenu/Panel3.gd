extends TextureButton


var artefact_name = "mana_ring"



func boost():
	if $"../..".artefacts.current_artefact1_artefact_name == artefact_name:
		mana_ring()
	elif $"../..".artefacts.current_artefact2_artefact_name == artefact_name:
		mana_ring()
	elif $"../..".artefacts.current_artefact3_artefact_name == artefact_name:
		mana_ring()
	elif $"../..".artefacts.current_artefact4_artefact_name == artefact_name:
		mana_ring()
	else:
		Hud.get_node("ManaBar").mana_ring = 1
		Hud.get_node("ManaBar").set_to_max()
		


func mana_ring():
	Hud.get_node("ManaBar").mana_ring = 1.1
	Hud.get_node("ManaBar").set_to_max()
