extends Node

onready var settingsmenu = load("res://ControlTest.tscn")
var filepath = "res://keybinds.ini"
var configfile

var keybinds = {}	 #keybinds dictionary

func _ready():
	configfile = ConfigFile.new()
	if configfile.load(filepath) == OK: #checking if the file exist
		for key in configfile.get_section_keys("keybinds"): #gives us the kezs in a particular section, key referes to the names of variables, not the value
			var key_value = configfile.get_value("keybinds", key) # gets the value
		 #	print(key, " : ", OS.get_scancode_string(key_value)) checkin if godot can read the file
			if str(key_value) != "":
				keybinds[key] = key_value
			else:
				keybinds[key] = null
	else:
		print("CONFIG FILE NOT FOUND")
		get_tree().quit()
	
	set_game_binds()

func set_game_binds():		# looping through all of the keybinds in keybinds dictionary
	for key in keybinds.keys(): # get list of the keys in the dictionary
		var value = keybinds[key] # referes to keybinds with index of key
		
		var actionlist = InputMap.get_action_list(key) # list of keys that currently activate action
		if !actionlist.empty(): 
			InputMap.action_erase_event(key, actionlist[0])
		
		if value != null:
			var new_key = InputEventKey.new()
			new_key.set_scancode(value)
			InputMap.action_add_event(key, new_key)

func write_config(): # writing new binds to setting file (stays the same when we launch the game)
	for key in keybinds.keys():
		var key_value = keybinds[key]
		if key_value != null:
			configfile.set_value("keybinds", key, key_value)
		else:
			configfile.set_value("keybinds", key, "")
	configfile.save(filepath)
