extends Node2D


const LIVES_OFFSET = 21 #how far are the lives apart
var health_amulet = 0

func _ready() -> void:
	draw_lives()

func _physics_process(delta):
	if PlayerBasicData.current_lives == 0:
		set_physics_process(false)
	lose_live()

func draw_lives():
	for i in PlayerBasicData.max_lives:
		var live = Sprite.new()
		add_child(live)
		var index = live.get_index()
		live.position.x = index * LIVES_OFFSET
		live.texture = load("res://assets/HUD/Heart_empty.png")
	for i in PlayerBasicData.current_lives:
		get_child(i).texture = load("res://assets/HUD/Heart.png")

func upgrade_live(var live_upgrade):
	PlayerBasicData.max_lives += live_upgrade
	if live_upgrade < 0:
		get_child(get_child_count()-1).queue_free()
	else:
		for i in live_upgrade:
			var live = Sprite.new()
			add_child(live)
			var index = live.get_index()
			live.position.x = index * LIVES_OFFSET
			live.texture = load("res://assets/HUD/Heart_empty.png")

func lose_live(): #removes lives if player gets hit
	if PlayerBasicData.current_lives < 0:
		PlayerBasicData.current_lives = 0
	if PlayerBasicData.current_lives < PlayerBasicData.max_lives:
		get_child(PlayerBasicData.current_lives).texture = load("res://assets/HUD/Heart_empty.png")

func update_lives():
	for i in get_children().size():
		if i < PlayerBasicData.current_lives:
			get_child(i).texture = load("res://assets/HUD/Heart.png")
		else:
			get_child(i).texture = load("res://assets/HUD/Heart_empty.png")
