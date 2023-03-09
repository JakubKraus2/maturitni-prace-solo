extends Node


const SAVE_PATH = "user://save_file.save"
var game_data = {}


func _ready() -> void:
	load_data()

func save_data():
	var file = File.new()
	file.open(SAVE_PATH, File.WRITE)
	file.store_var(game_data)
	file.close()

func load_data():
	var file = File.new()
	if !file.file_exists(SAVE_PATH):
		game_data = {
			"positionx": 0,
			"positiony": 0,
			"max_lives": 5,
			"current_lives": 5,
			"max_healing": 3,
			"current_healing": 3,
			"max_mana": 100,
			"current_mana": 100,
			"damage_upgrade": 1,
			"current_skill1": "",
			"current_skill1_mana_cost": 0,
			"current_skill1_damage": 0,
			"current_skill2": "",
			"current_skill2_mana_cost": 0,
			"current_skill2_damage": 0,
			"current_skill3": "",
			"current_skill3_mana_cost": 0,
			"current_skill3_damage": 0,
			"health_amulet_equipped": false,
			"can_double_jump": false,
			"can_wall_climb": false
		}
		save_data()
	file.open(SAVE_PATH, File.READ)
	game_data = file.get_var()
	file.close()
