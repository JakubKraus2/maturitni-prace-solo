extends Node2D


const HEALING_OFFSET = 16 #how far are the healing items apart


func _ready() -> void:
	draw_healing()

func _physics_process(delta):
	if PlayerBasicData.current_lives == 0:
		set_physics_process(false)
	get_heal_input()

func draw_healing():
	for i in PlayerBasicData.max_healing:
		var healing = Sprite.new()
		add_child(healing)
		var index = healing.get_index()
		healing.position.x = index * HEALING_OFFSET
		healing.texture = load("res://assets/HUD/Healing_empty.png")
	for i in PlayerBasicData.current_healing:
		get_child(i).texture = load("res://assets/HUD/Healing.png")

func heal():
	if PlayerBasicData.current_healing < 0:
		PlayerBasicData.current_healing = 0
	if PlayerBasicData.current_healing < PlayerBasicData.max_healing:
		get_child(PlayerBasicData.current_healing).texture = load("res://assets/HUD/Healing_empty.png")
		get_parent().get_node("Lives").get_child(PlayerBasicData.current_lives-1).texture = load("res://assets/HUD/Heart.png")

func get_heal_input():
	if Input.is_action_just_pressed("heal") && SwordsMaster.get_node("AnimationPlayer").current_animation != "HEALING" && PlayerBasicData.current_lives < PlayerBasicData.max_lives && PlayerBasicData.current_healing != 0 && SwordsMaster.is_on_floor():
		PlayerBasicData.current_healing -= 1
		PlayerBasicData.current_lives += 1
		SwordsMaster.attacking = true
		SwordsMaster.can_dash = false
		SwordsMaster.get_node("AnimationPlayer").play("HEALING")
		heal()

func upgrade_heal(var heal_upgrade):
	PlayerBasicData.max_healing += heal_upgrade
	for i in heal_upgrade:
		var healing = Sprite.new()
		add_child(healing)
		var index = healing.get_index()
		healing.position.x = index * HEALING_OFFSET
		healing.texture = load("res://assets/HUD/Healing_empty.png")

func update_healing():
	for i in get_children().size():
		if i < PlayerBasicData.current_healing:
			get_child(i).texture = load("res://assets/HUD/Healing.png")
		else:
			get_child(i).texture = load("res://assets/HUD/Healing_empty.png")

func check_max_healing():
	for i in get_children().size():
		if i > PlayerBasicData.max_healing-1:
			get_child(i).remove_and_skip()
