extends Node2D

onready var game_data = SaveFile.game_data

var current_lives = 0
var max_lives = 0

var current_healing = 0
var max_healing = 0

var current_mana = 0
var max_mana = 0

func _ready() -> void:
	current_lives = game_data.current_lives
	max_lives = game_data.max_lives
	
	current_healing = game_data.current_healing
	max_healing = game_data.max_healing
	
	current_mana = game_data.current_mana
	max_mana = game_data.max_mana
