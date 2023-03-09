extends TextureButton


var artefact_name = "speed_totem"



func boost():
	if $"../..".artefacts.current_artefact1_artefact_name == artefact_name:
		idol_of_haste()
	elif $"../..".artefacts.current_artefact2_artefact_name == artefact_name:
		idol_of_haste()
	elif $"../..".artefacts.current_artefact3_artefact_name == artefact_name:
		idol_of_haste()
	elif $"../..".artefacts.current_artefact4_artefact_name == artefact_name:
		idol_of_haste()
	else:
		SwordsMaster.idol_of_haste_boost = 1


func idol_of_haste():
	SwordsMaster.idol_of_haste_boost = 1.25
