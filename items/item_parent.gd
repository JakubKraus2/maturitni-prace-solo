extends Area2D


onready var SAVE_PATH = "user://" + name + "_" + str(get_tree().current_scene.name) + "_save_file.save"
onready var game_data = SaveFile.game_data
var picked_status = {}


func _ready() -> void:
	load_data()
	if picked_status.picked == true:
		queue_free()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept") && get_overlapping_areas():
		$AnimationTree.set_condition("pick", true)
		picked_status.picked = true
		save_data()


func _on_Item_area_entered(area: Area2D) -> void:
	$PickText.visible = true

func _on_Item_area_exited(area: Area2D) -> void:
	$PickText.visible = false

func save_player_data():
	game_data.max_lives = PlayerBasicData.max_lives
	game_data.current_lives = PlayerBasicData.current_lives
	game_data.max_healing = PlayerBasicData.max_healing
	game_data.current_healing = PlayerBasicData.current_healing
	game_data.max_mana = PlayerBasicData.max_mana
	game_data.current_mana = PlayerBasicData.current_mana
	game_data.damage_upgrade = PlayerAttacksDamage.damage_upgrade
	SaveFile.save_data()

func save_data():
	var file = File.new()
	file.open(SAVE_PATH, File.WRITE)
	file.store_var(picked_status)
	file.close()

func load_data():
	var file = File.new()
	if !file.file_exists(SAVE_PATH):
		picked_status = {
			"picked": false
		}
		save_data()
	file.open(SAVE_PATH, File.READ)
	picked_status = file.get_var()
	file.close()
