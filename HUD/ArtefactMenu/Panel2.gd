extends TextureButton


var artefact_name = "health_amulet"



func boost():
	if $"../..".artefacts.current_artefact1_artefact_name == artefact_name:
		health_amulet()
	elif $"../..".artefacts.current_artefact2_artefact_name == artefact_name:
		health_amulet()
	elif $"../..".artefacts.current_artefact3_artefact_name == artefact_name:
		health_amulet()
	elif $"../..".artefacts.current_artefact4_artefact_name == artefact_name:
		health_amulet()
	else:
		if SaveFile.game_data.health_amulet_equipped == true:
			Hud.get_node("Lives").upgrade_live(-1)
			PlayerBasicData.current_lives -= 1
			SaveFile.game_data.max_lives = PlayerBasicData.max_lives
			SaveFile.game_data.current_lives = PlayerBasicData.current_lives
			SaveFile.game_data.health_amulet_equipped = false
			SaveFile.save_data()

func health_amulet():
	if !SaveFile.game_data.health_amulet_equipped:
		Hud.get_node("Lives").upgrade_live(1)
		PlayerBasicData.current_lives = PlayerBasicData.max_lives
		Hud.get_node("Lives").update_lives()
		SaveFile.game_data.max_lives = PlayerBasicData.max_lives
		SaveFile.game_data.current_lives = PlayerBasicData.current_lives
		SaveFile.game_data.health_amulet_equipped = true
		SaveFile.save_data()
