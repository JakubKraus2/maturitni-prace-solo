extends CanvasLayer

export(String, FILE, "*.json") var dialogue_file

var dialogues = []
var current_dialogue_id = 0
var is_dialogue_active = false

var display = ""
var current_char = 0

func _ready():
	$NinePatchRect.visible = false #invisible until we press "E"

func play():
	if is_dialogue_active:
		return

	dialogues = load_dialogues()
	
	SwordsMaster.attacking = true
	SwordsMaster.can_dash = false
	is_dialogue_active = true
	$NinePatchRect.visible = true
	current_dialogue_id -= 1
	$CharTimer.start(0.075) #text reading speed: 1 = 1 second
	next_line()

func _input(event):
	if  !is_dialogue_active:
		return
	
	if event.is_action_pressed("ui_select") && current_char >= len(dialogues[current_dialogue_id]["text"]): #if "E" is pressed and it's the end of the current dialogue message
		next_line()

func next_line():
	display = "" #reset text to nothing
	current_char = 0 #reset chars to nothing
	current_dialogue_id += 1 #next message
	if current_dialogue_id >= len(dialogues): # if there's no next text
		SwordsMaster.attacking = false
		SwordsMaster.can_dash = true
		queue_free()
		return
	
	$NinePatchRect/name.text = dialogues[current_dialogue_id]["name"]

func load_dialogues():
	var file = File.new()
	if file.file_exists(dialogue_file):
		file.open(dialogue_file, file.READ)
		return parse_json(file.get_as_text())

func _on_CharTimer_timeout() -> void:
	if is_dialogue_active && current_char < len(dialogues[current_dialogue_id]["text"]): #if there are characters left add character to text one by one
		display += dialogues[current_dialogue_id]["text"][current_char]
		current_char += 1

func _process(delta: float) -> void:
	$NinePatchRect/message.text = display #add characters to dialogue text
