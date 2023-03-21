extends CanvasLayer

onready var buttoncontainer = get_node("Panel/VBoxContainer")
onready var buttonscript = load("res://KeyButton.gd")

var keybinds #keybinds dictionary
var buttons = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	keybinds = Global.keybinds.duplicate() #keybinds dictionary duplicate, making changes only to the duplicate
	for key in keybinds.keys():
		var hbox = HBoxContainer.new()
		var label = Label.new() # to recognize which setting it is
		var button = Button.new() 
		
		hbox.set_h_size_flags(Control.SIZE_EXPAND_FILL)
		label.set_h_size_flags(Control.SIZE_EXPAND_FILL)
		button.set_h_size_flags(Control.SIZE_EXPAND_FILL)
		
		label.text = key # correct name of the key
		
		var button_value = keybinds[key]
		
		if button_value != null:
			button.text = OS.get_scancode_string(button_value)
		else:
			button.text = "Unassigned"
		
		button.set_script(buttonscript)
		button.key = key
		button.value = button_value
		button.menu = self
		button.toggle_mode = true
		button.focus_mode = Control.FOCUS_NONE
		
		hbox.add_child(label)
		hbox.add_child(button)
		buttoncontainer.add_child(hbox)
		
		buttons[key] = button

func change_bind(key, value):
	keybinds[key] = value
	for k in keybinds.keys():
		if k != key and value != null and keybinds[k] == value: # checkinf for ocerlapping keys
			keybinds[k] = null
			buttons[k].value = null
			buttons[k].text = "Unassigned"

func _on_back_pressed():
	queue_free()

func _on_save_pressed():
	Global.keybinds = keybinds.duplicate()
	Global.set_game_binds()
	Global.write_config()
	_on_back_pressed()
