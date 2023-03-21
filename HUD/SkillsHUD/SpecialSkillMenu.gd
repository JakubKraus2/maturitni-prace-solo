extends CanvasLayer


const SAVE_PATH = "user://skill_inventory_save_file.save"
var skills = {}

export(ButtonGroup) var skill1_group #only one button can be pressed in Skills1 menu
export(ButtonGroup) var skill2_group
export(ButtonGroup) var skill3_group


func _ready():
	load_data()
	print(skills)
	for i in skill1_group.get_buttons(): #get all buttons in skill1_group
		i.connect("pressed", self, "skill1_button_pressed") #connect signal pressed on itself and renamed it to skill1_button_pressed
	for j in skill2_group.get_buttons():
		j.connect("pressed", self, "skill2_button_pressed")
	for k in skill3_group.get_buttons():
		k.connect("pressed", self, "skill3_button_pressed")

func skill1_button_pressed(): #after clicking on certain button in skill1 group do the following
	$DesciptionContainer.update_description_skill1()
	skills.current_skill1_texture_normal = skill1_group.get_pressed_button().texture_normal.resource_path
	skills.current_skill1_texture_pressed = skill1_group.get_pressed_button().texture_pressed.resource_path
	
	$CurrentSkills/Panel1.texture_normal = load(skills.current_skill1_texture_normal) #set its texture to the pressed button texture
	$CurrentSkills/Panel1.texture_pressed = load(skills.current_skill1_texture_pressed) #set its texture to the pressed button texture
	HudSkill.get_node("HUDSkillIcon3").texture = load(skills.current_skill1_texture_normal)
	HudSkill.current_skill1 = skill1_group.get_pressed_button().skill
	HudSkill.current_skill1_mana_cost = skill1_group.get_pressed_button().mana_cost
	HudSkill.current_skill1_damage = skill1_group.get_pressed_button().damage
	
	SaveFile.game_data.current_skill1 = skill1_group.get_pressed_button().skill
	SaveFile.game_data.current_skill1_mana_cost = skill1_group.get_pressed_button().mana_cost
	SaveFile.game_data.current_skill1_damage = skill1_group.get_pressed_button().damage
	SaveFile.save_data()
	save_data()

func skill2_button_pressed():
	$DesciptionContainer.update_description_skill2()
	skills.current_skill2_texture_normal = skill2_group.get_pressed_button().texture_normal.resource_path
	skills.current_skill2_texture_pressed = skill2_group.get_pressed_button().texture_pressed.resource_path

	$CurrentSkills/Panel2.texture_normal = load(skills.current_skill2_texture_normal)
	$CurrentSkills/Panel2.texture_pressed = load(skills.current_skill2_texture_pressed)
	HudSkill.get_node("HUDSkillIcon2").texture = load(skills.current_skill2_texture_normal)
	HudSkill.current_skill2 = skill2_group.get_pressed_button().skill
	HudSkill.current_skill2_mana_cost = skill2_group.get_pressed_button().mana_cost
	HudSkill.current_skill2_damage = skill2_group.get_pressed_button().damage
	
	SaveFile.game_data.current_skill2 = skill2_group.get_pressed_button().skill
	SaveFile.game_data.current_skill2_mana_cost = skill2_group.get_pressed_button().mana_cost
	SaveFile.game_data.current_skill2_damage = skill2_group.get_pressed_button().damage
	SaveFile.save_data()
	save_data()

func skill3_button_pressed():
	$DesciptionContainer.update_description_skill3()
	skills.current_skill3_texture_normal = skill3_group.get_pressed_button().texture_normal.resource_path
	skills.current_skill3_texture_pressed = skill3_group.get_pressed_button().texture_pressed.resource_path

	$CurrentSkills/Panel3.texture_normal = load(skills.current_skill3_texture_normal)
	$CurrentSkills/Panel3.texture_pressed = load(skills.current_skill3_texture_pressed)
	HudSkill.get_node("HUDSkillIcon1").texture = load(skills.current_skill3_texture_normal)
	HudSkill.current_skill3 = skill3_group.get_pressed_button().skill
	HudSkill.current_skill3_mana_cost = skill3_group.get_pressed_button().mana_cost
	HudSkill.current_skill3_damage = skill3_group.get_pressed_button().damage
	
	SaveFile.game_data.current_skill3 = skill3_group.get_pressed_button().skill
	SaveFile.game_data.current_skill3_mana_cost = skill3_group.get_pressed_button().mana_cost
	SaveFile.game_data.current_skill3_damage = skill3_group.get_pressed_button().damage
	SaveFile.save_data()
	save_data()


func _on_Panel1_toggled(button_pressed: bool) -> void:
	$Skills1.visible = button_pressed

func _on_Panel2_toggled(button_pressed: bool) -> void:
	$Skills2.visible = button_pressed

func _on_Panel3_toggled(button_pressed: bool) -> void:
	$Skills3.visible = button_pressed


func save_data():
	var file = File.new()
	file.open(SAVE_PATH, File.WRITE)
	file.store_var(skills)
	file.close()

func load_data():
	var file = File.new()
	if !file.file_exists(SAVE_PATH):
		skills = {
			"current_skill1_texture_normal": $CurrentSkills/Panel1.texture_normal.resource_path,
			"current_skill1_texture_pressed": $CurrentSkills/Panel1.texture_pressed.resource_path,
			"current_skill2_texture_normal": $CurrentSkills/Panel2.texture_normal.resource_path,
			"current_skill2_texture_pressed": $CurrentSkills/Panel2.texture_pressed.resource_path,
			"current_skill3_texture_normal": $CurrentSkills/Panel3.texture_normal.resource_path,
			"current_skill3_texture_pressed": $CurrentSkills/Panel3.texture_pressed.resource_path,
			
			"skills_panel1_disabled": true,
			"skills_panel2_disabled": true,
			"skills_panel3_disabled": true,
			"skills_panel4_disabled": true,
			"skills_panel5_disabled": true,
			"skills_panel6_disabled": true,
			"skills_panel7_disabled": true,
			"skills_panel8_disabled": true,
		}
		save_data()
	file.open(SAVE_PATH, File.READ)
	skills = file.get_var()
	file.close()
	$CurrentSkills/Panel1.texture_normal = load(skills.current_skill1_texture_normal)
	$CurrentSkills/Panel1.texture_pressed = load(skills.current_skill1_texture_pressed)
	$CurrentSkills/Panel2.texture_normal = load(skills.current_skill2_texture_normal)
	$CurrentSkills/Panel2.texture_pressed = load(skills.current_skill2_texture_pressed)
	$CurrentSkills/Panel3.texture_normal = load(skills.current_skill3_texture_normal)
	$CurrentSkills/Panel3.texture_pressed = load(skills.current_skill3_texture_pressed)
	
	HudSkill.get_node("HUDSkillIcon3").texture = load(skills.current_skill1_texture_normal)
	HudSkill.get_node("HUDSkillIcon2").texture = load(skills.current_skill2_texture_normal)
	HudSkill.get_node("HUDSkillIcon1").texture = load(skills.current_skill3_texture_normal)
	
	$Skills1/Panel1.disabled = skills.skills_panel1_disabled
	$Skills2/Panel1.disabled = skills.skills_panel1_disabled
	$Skills3/Panel1.disabled = skills.skills_panel1_disabled
	
	$Skills1/Panel2.disabled = skills.skills_panel2_disabled
	$Skills2/Panel2.disabled = skills.skills_panel2_disabled
	$Skills3/Panel2.disabled = skills.skills_panel2_disabled
	
	$Skills1/Panel3.disabled = skills.skills_panel3_disabled
	$Skills2/Panel3.disabled = skills.skills_panel3_disabled
	$Skills3/Panel3.disabled = skills.skills_panel3_disabled
	
	$Skills1/Panel4.disabled = skills.skills_panel4_disabled
	$Skills2/Panel4.disabled = skills.skills_panel4_disabled
	$Skills3/Panel4.disabled = skills.skills_panel4_disabled
	
	$Skills1/Panel5.disabled = skills.skills_panel5_disabled
	$Skills2/Panel5.disabled = skills.skills_panel5_disabled
	$Skills3/Panel5.disabled = skills.skills_panel5_disabled
	
	$Skills1/Panel6.disabled = skills.skills_panel6_disabled
	$Skills2/Panel6.disabled = skills.skills_panel6_disabled
	$Skills3/Panel6.disabled = skills.skills_panel6_disabled
	
	$Skills1/Panel7.disabled = skills.skills_panel7_disabled
	$Skills2/Panel7.disabled = skills.skills_panel7_disabled
	$Skills3/Panel7.disabled = skills.skills_panel7_disabled
	
	$Skills1/Panel8.disabled = skills.skills_panel8_disabled
	$Skills2/Panel8.disabled = skills.skills_panel8_disabled
	$Skills3/Panel8.disabled = skills.skills_panel8_disabled
