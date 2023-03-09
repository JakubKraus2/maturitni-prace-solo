extends VBoxContainer

export(String, FILE, "*.json") var artefact_description_file

var artefact_description = []


func update_description_artefact1():
	if $"..".artefact1_group.get_pressed_button() != null:
		artefact_description = load_description()
		$CenterContainer/ArtefactName.text = artefact_description[get_parent().artefact1_group.get_pressed_button().get_index()]['name']
		$CenterContainer2/Icon.texture = load(artefact_description[get_parent().artefact1_group.get_pressed_button().get_index()]['icon'])
		$ArtefactDescription.text = artefact_description[get_parent().artefact1_group.get_pressed_button().get_index()]['description']

func update_description_artefact2():
	if $"..".artefact2_group.get_pressed_button() != null:
		artefact_description = load_description()
		$CenterContainer/ArtefactName.text = artefact_description[get_parent().artefact2_group.get_pressed_button().get_index()]['name']
		$CenterContainer2/Icon.texture = load(artefact_description[get_parent().artefact2_group.get_pressed_button().get_index()]['icon'])
		$ArtefactDescription.text = artefact_description[get_parent().artefact2_group.get_pressed_button().get_index()]['description']

func update_description_artefact3():
	if $"..".artefact3_group.get_pressed_button() != null:
		artefact_description = load_description()
		$CenterContainer/ArtefactName.text = artefact_description[get_parent().artefact3_group.get_pressed_button().get_index()]['name']
		$CenterContainer2/Icon.texture = load(artefact_description[get_parent().artefact3_group.get_pressed_button().get_index()]['icon'])
		$ArtefactDescription.text = artefact_description[get_parent().artefact3_group.get_pressed_button().get_index()]['description']

func update_description_artefact4():
	if $"..".artefact4_group.get_pressed_button() != null:
		artefact_description = load_description()
		$CenterContainer/ArtefactName.text = artefact_description[get_parent().artefact4_group.get_pressed_button().get_index()]['name']
		$CenterContainer2/Icon.texture = load(artefact_description[get_parent().artefact4_group.get_pressed_button().get_index()]['icon'])
		$ArtefactDescription.text = artefact_description[get_parent().artefact4_group.get_pressed_button().get_index()]['description']

func load_description():
	var file = File.new()
	if file.file_exists(artefact_description_file):
		file.open(artefact_description_file, file.READ)
		return parse_json(file.get_as_text())
