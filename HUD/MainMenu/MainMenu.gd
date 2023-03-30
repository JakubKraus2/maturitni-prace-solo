extends CanvasLayer


onready var settingsmenu = load("res://ControlTest.tscn")


func _ready() -> void:
	GlobalMusic.play_main_menu()
	$AnimationPlayer.play("DEFAULT")
	$Node2D/MainContainer/ButtonsCenterContainer/Buttons/LoadGameButton.disabled = true if SaveFile.game_data.current_scene == "" else false


func _on_QuitGameButton_pressed():
	get_tree().quit()

func _on_OptionsButton_pressed() -> void:
	get_parent().add_child(settingsmenu.instance())

func _on_LoadGameButton_pressed() -> void:
	$AnimationPlayer.play("LOAD_GAME")

func _on_NewGameButton_pressed() -> void:
	$AnimationPlayer.play("NEW_GAME")


func load_game():
	GlobalMusic.play_idle()
	SwordsMaster.velocity.y = 0
	SwordsMaster.velocity.x = 0
	SwordsMaster.global_position.x = SaveFile.game_data.positionx
	SwordsMaster.global_position.y = SaveFile.game_data.positiony
	get_tree().change_scene(SaveFile.game_data.current_scene)
	LoadingScreen.get_node("AnimationPlayer").play("LOADING")

func new_game():
	GlobalMusic.play_idle()
	if SaveFile.game_data.health_amulet_equipped == true:
		Hud.get_node("Lives").upgrade_live(-1)
		PlayerBasicData.current_lives -= 1
		SaveFile.game_data.max_lives = PlayerBasicData.max_lives
		SaveFile.game_data.current_lives = PlayerBasicData.current_lives
		SaveFile.game_data.health_amulet_equipped = false
		SaveFile.save_data()
	delete_all_files("user://")
	reset_player()
	reset_skill_ui()
	reset_artefacts_ui()
	reset_hud_ui()
	SwordsMaster.double_jump = false
	SaveFile.save_data()
	SpecialSkillMenu.save_data()
	ArtefactMenu.save_data()
	SwordsMaster.attacking = false
	SwordsMaster.can_dash = true
	LoadingScreen.get_node("AnimationPlayer").play("LOADING")


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

func reset_player():
	SaveFile.load_data()
	PlayerBasicData._ready()
	SwordsMaster.velocity.y = 0
	SwordsMaster.velocity.x = 0
	SwordsMaster.global_position.x = SaveFile.game_data.positionx
	SwordsMaster.global_position.y = SaveFile.game_data.positiony
	get_tree().change_scene("res://scenes/DemoLevel.tscn")
	SaveFile.game_data.current_scene = "res://scenes/DemoLevel.tscn"

func reset_hud_ui():
	Hud.get_node("Lives").check_max_lives()
	Hud.get_node("Lives").update_lives()
	Hud.get_node("Healing").check_max_healing()
	Hud.get_node("Healing").update_healing()
	Hud.get_node("ManaBar").set_to_max()

func reset_skill_ui():
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
	SpecialSkillMenu.skills.current_skill1_texture_normal = "res://assets/HUD/skills/skill_icon.png"
	SpecialSkillMenu.skills.current_skill2_texture_normal = "res://assets/HUD/skills/skill_icon.png"
	SpecialSkillMenu.skills.current_skill3_texture_normal = "res://assets/HUD/skills/skill_icon.png"

func reset_artefacts_ui():
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
	ArtefactMenu.artefacts.current_artefact1_texture_normal = "res://assets/HUD/artefacts/artefact_icon.png"
	ArtefactMenu.artefacts.current_artefact2_texture_normal = "res://assets/HUD/artefacts/artefact_icon.png"
	ArtefactMenu.artefacts.current_artefact3_texture_normal = "res://assets/HUD/artefacts/artefact_icon.png"
	ArtefactMenu.artefacts.current_artefact4_texture_normal = "res://assets/HUD/artefacts/artefact_icon.png"
	for i in ArtefactMenu.get_node("Artefacts1").get_child_count():
		ArtefactMenu.get_node("Artefacts1").get_child(i).boost()
	StatusMenu.update_stats()
