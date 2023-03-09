extends VBoxContainer

export(String, FILE, "*.json") var skill_desciprion_file

var skill_description = []


func update_description_skill1():
	skill_description = load_description()
	$CenterContainer/SkillName.text = skill_description[get_parent().skill1_group.get_pressed_button().get_index()]['name']
	$CenterContainer2/Icon.texture = load(skill_description[get_parent().skill1_group.get_pressed_button().get_index()]['icon'])
	$SkillDescription.text = skill_description[get_parent().skill1_group.get_pressed_button().get_index()]['description']
	$CenterContainer3/SkillManaCost.text = "mana cost: " + str(get_parent().skill1_group.get_pressed_button().mana_cost)

func update_description_skill2():
	skill_description = load_description()
	$CenterContainer/SkillName.text = skill_description[get_parent().skill2_group.get_pressed_button().get_index()]['name']
	$CenterContainer2/Icon.texture = load(skill_description[get_parent().skill2_group.get_pressed_button().get_index()]['icon'])
	$SkillDescription.text = skill_description[get_parent().skill2_group.get_pressed_button().get_index()]['description']
	$CenterContainer3/SkillManaCost.text = "mana cost: " + str(get_parent().skill2_group.get_pressed_button().mana_cost)

func update_description_skill3():
	skill_description = load_description()
	$CenterContainer/SkillName.text = skill_description[get_parent().skill3_group.get_pressed_button().get_index()]['name']
	$CenterContainer2/Icon.texture = load(skill_description[get_parent().skill3_group.get_pressed_button().get_index()]['icon'])
	$SkillDescription.text = skill_description[get_parent().skill3_group.get_pressed_button().get_index()]['description']
	$CenterContainer3/SkillManaCost.text = "mana cost: " + str(get_parent().skill3_group.get_pressed_button().mana_cost)

func load_description():
	var file = File.new()
	if file.file_exists(skill_desciprion_file):
		file.open(skill_desciprion_file, file.READ)
		return parse_json(file.get_as_text())
