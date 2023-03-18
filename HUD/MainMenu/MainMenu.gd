extends CanvasLayer


onready var settingsmenu = load("res://ControlTest.tscn")


func _ready() -> void:
	$Node2D/MainContainer/ButtonsCenterContainer/Buttons/LoadGameButton.disabled = true if SaveFile.game_data.current_scene == "" else false


func _on_QuitGameButton_pressed():
	get_tree().quit()


func _on_OptionsButton_pressed() -> void:
	get_parent().add_child(settingsmenu.instance())


func _on_LoadGameButton_pressed() -> void:
	SwordsMaster.velocity.y = 0
	SwordsMaster.velocity.x = 0
	SwordsMaster.global_position.x = SaveFile.game_data.positionx
	SwordsMaster.global_position.y = SaveFile.game_data.positiony
	get_tree().change_scene(SaveFile.game_data.current_scene)


func _on_NewGameButton_pressed() -> void:
	delete_all_files("user://")
	
	#PLAYER POSITION -> need to set hp, mana, healing to max
	SaveFile.load_data()
	PlayerBasicData._ready()
	SwordsMaster.velocity.y = 0
	SwordsMaster.velocity.x = 0
	SwordsMaster.global_position.x = SaveFile.game_data.positionx
	SwordsMaster.global_position.y = SaveFile.game_data.positiony
	get_tree().change_scene("res://scenes/BossArena.tscn")
	SaveFile.game_data.current_scene = "res://scenes/BossArena.tscn"
	
	SpecialSkillMenu.load_data()
	HudSkill._ready()
	HudSkill.get_node("HUDSkillIcon3").texture = load("res://assets/HUD/skills/skill_icon.png")
	HudSkill.get_node("HUDSkillIcon2").texture = load("res://assets/HUD/skills/skill_icon.png")
	HudSkill.get_node("HUDSkillIcon1").texture = load("res://assets/HUD/skills/skill_icon.png")
	SpecialSkillMenu.get_node("CurrentSkills/Panel1").texture_normal = load("res://assets/HUD/skills/skill_icon.png")
	SpecialSkillMenu.get_node("CurrentSkills/Panel2").texture_normal = load("res://assets/HUD/skills/skill_icon.png")
	SpecialSkillMenu.get_node("CurrentSkills/Panel3").texture_normal = load("res://assets/HUD/skills/skill_icon.png")
	SpecialSkillMenu.get_node("CurrentSkills/Panel1").texture_pressed = load("res://assets/HUD/skills/skill_icon_clicked.png")
	SpecialSkillMenu.get_node("CurrentSkills/Panel2").texture_pressed = load("res://assets/HUD/skills/skill_icon_clicked.png")
	SpecialSkillMenu.get_node("CurrentSkills/Panel3").texture_pressed = load("res://assets/HUD/skills/skill_icon_clicked.png")
	SpecialSkillMenu.get_node("DesciptionContainer/CenterContainer/SkillName").text = ""
	SpecialSkillMenu.get_node("DesciptionContainer/CenterContainer2/Icon").texture = load("res://assets/HUD/skills/nothing.png")
	SpecialSkillMenu.get_node("DesciptionContainer/SkillDescription").text = ""
	SpecialSkillMenu.get_node("DesciptionContainer/CenterContainer3/SkillManaCost").text = ""

	ArtefactMenu.load_data()
	ArtefactMenu.artefacts.current_artefact1_artefact_name = ""
	ArtefactMenu.artefacts.current_artefact2_artefact_name = ""
	ArtefactMenu.artefacts.current_artefact3_artefact_name = ""
	ArtefactMenu.artefacts.current_artefact4_artefact_name = ""
	ArtefactMenu.get_node("CurrentArtefacts/Panel1").artefact_name = ""
	ArtefactMenu.get_node("CurrentArtefacts/Panel2").artefact_name = ""
	ArtefactMenu.get_node("CurrentArtefacts/Panel3").artefact_name = ""
	ArtefactMenu.get_node("CurrentArtefacts/Panel4").artefact_name = ""
	ArtefactMenu.get_node("CurrentArtefacts/Panel1").texture_normal = load("res://assets/HUD/artefacts/artefact_icon.png")
	ArtefactMenu.get_node("CurrentArtefacts/Panel2").texture_normal = load("res://assets/HUD/artefacts/artefact_icon.png")
	ArtefactMenu.get_node("CurrentArtefacts/Panel3").texture_normal = load("res://assets/HUD/artefacts/artefact_icon.png")
	ArtefactMenu.get_node("CurrentArtefacts/Panel4").texture_normal = load("res://assets/HUD/artefacts/artefact_icon.png")
	ArtefactMenu.get_node("CurrentArtefacts/Panel1").texture_pressed = load("res://assets/HUD/artefacts/artefact_icon_pressed.png")
	ArtefactMenu.get_node("CurrentArtefacts/Panel2").texture_pressed = load("res://assets/HUD/artefacts/artefact_icon_pressed.png")
	ArtefactMenu.get_node("CurrentArtefacts/Panel3").texture_pressed = load("res://assets/HUD/artefacts/artefact_icon_pressed.png")
	ArtefactMenu.get_node("CurrentArtefacts/Panel4").texture_pressed = load("res://assets/HUD/artefacts/artefact_icon_pressed.png")
	ArtefactMenu.get_node("DesciptionContainer/CenterContainer/ArtefactName").text = ""
	ArtefactMenu.get_node("DesciptionContainer/CenterContainer2/Icon").texture = load("res://assets/HUD/skills/nothing.png")
	ArtefactMenu.get_node("DesciptionContainer/ArtefactDescription").text = ""
	for i in ArtefactMenu.get_node("Artefacts1").get_child_count():
		ArtefactMenu.get_node("Artefacts1").get_child(i).boost()
#	SaveFile.load_data()
#	SpecialSkillMenu.load_data()
#	ArtefactMenu.load_data()
#	SwordsMaster.velocity.y = 0
#	SwordsMaster.velocity.x = 0
#	SwordsMaster.global_position.x = SaveFile.SaveFile.game_data.positionx
#	SwordsMaster.global_position.y = SaveFile.SaveFile.game_data.positiony
#	get_tree().change_scene("res://scenes/BossArena.tscn")
#	PlayerBasicData._ready() #load new stats
#	Hud.get_node("Lives").update_lives() #fill lives to full
#	Hud.get_node("Healing").update_healing() #fill healing to full
#	SaveFile.save_data()

func delete_all_files(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif !file.begins_with("."):
			dir.remove(file)
	dir.list_dir_end()
	return files
