extends CanvasLayer

export(String, FILE, "*.json") var item_file

var item = []

func _ready() -> void:
	play()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") && visible == true:
		$AnimationPlayer.play("CLOSE")

func play():
	item = load_item()
	$NinePatchRect/NameLabel.text = item[0]['name']
	$NinePatchRect/Icon.texture = load(item[0]['icon'])

func load_item():
	var file = File.new()
	if file.file_exists(item_file):
		file.open(item_file, file.READ)
		return parse_json(file.get_as_text())

func close():
	set_process(false)
	get_parent().visible = false
	get_parent().set_process(false)

func spawn():
	$AnimationPlayer.play("OPEN")
