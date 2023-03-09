extends CanvasLayer

export(String, FILE, "*.json") var ability_description_file

var ability_description = []



func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") && visible == true:
		$AnimationPlayer.play("CLOSE")

func play():
	$AnimationPlayer.play("SPAWN")
	ability_description = load_description()
	$NameText.text = ability_description[0]['name']
	$DescriptionContainer/Description.text = ability_description[0]['description']
	$DescriptionContainer/IconCenterContainer/Icon.texture = load(ability_description[0]['icon'])

func load_description():
	var file = File.new()
	if file.file_exists(ability_description_file):
		file.open(ability_description_file, file.READ)
		return parse_json(file.get_as_text())
