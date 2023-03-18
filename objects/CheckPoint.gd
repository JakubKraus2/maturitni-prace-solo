extends Area2D


onready var game_data = SaveFile.game_data


func _ready() -> void:
	$AnimationPlayer.play("DEFAULT")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") && get_overlapping_areas():
		save_and_load_all()
		respawn_enemies()
		CheckpointMenu.visible = true
	if CheckpointMenu.visible:
		SwordsMaster.attacking = true
		SwordsMaster.can_dash = false

func save_and_load_all():
	game_data.positionx = SwordsMaster.global_position.x #save to file
	game_data.positiony = SwordsMaster.global_position.y #save to file
	game_data.current_lives = PlayerBasicData.max_lives #save to file
	game_data.current_healing = PlayerBasicData.max_healing #save to file
	game_data.current_mana = PlayerBasicData.max_mana #save to file
	game_data.current_scene = get_tree().current_scene.filename
	SaveFile.save_data() #save the file
	PlayerBasicData._ready() #load new stats
	Hud.get_node("Lives").update_lives() #fill lives to full
	Hud.get_node("Healing").update_healing() #fill healing to full
	Hud.get_node("ManaBar").set_to_max() #fill mana to full
	print(game_data)

func respawn_enemies():
	get_tree().call_group("enemy", "respawn")

func _on_CheckPoint_area_entered(area: Area2D) -> void:
	$PickText.visible = true

func _on_CheckPoint_area_exited(area: Area2D) -> void:
	$PickText.visible = false
	CheckpointMenu.visible = false
	SpecialSkillMenu.visible = false
	StatusMenu.visible = false
	ArtefactMenu.visible = false
