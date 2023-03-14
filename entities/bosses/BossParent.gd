extends KinematicBody2D



onready var SAVE_PATH = "user://" + name + "_save_file.save"
var game_data = {}

export var velocity = Vector2(0,0)
export var speed = 0
var max_speed = speed
export var gravity = 20

export var max_knockback_power = 100
export var hp = 100
var max_hp = hp

var moving_left = true

onready var timer = $KnockBackTimer
onready var hurt_timer = $HurtTimer #after getting hit the boss texture goes red for a moment
onready var animation_player = $AnimationPlayer
onready var health_bar = get_node("BossHealthBar").get_child(0)



var direction

export var attack_knock_back_power = 1000
var attack_shake_power = 5.0


func _ready():
	load_data()

func _process(delta):
	if SwordsMaster.get_node("AnimationPlayerSpawn").current_animation == "SPAWN":
		set_process(false)
		moving_left = true
		hp = max_hp
		scale.x = scale.y
		global_position.x = game_data.current_positionx
		global_position.y = game_data.current_positiony
		_ready()

func _physics_process(delta):
	velocity.y = velocity.y + gravity
	velocity = move_and_slide(velocity, Vector2.UP)
	direction = SwordsMaster.position.x - position.x
	
	velocity.x = speed
	
	knock_back()

func _on_HurtTimer_timeout():
	modulate = Color(1, 1, 1) #boss texture goes back to normal


func knock_back():
	var knockback_power = max_knockback_power if $KnockBackTimer.time_left > 0 else 0
	velocity.x += knockback_power if direction < 0 else -knockback_power
	death()


func death():
	if hp <= 0:
		$SlowDownTimer.start()
		Engine.time_scale = 0.1
		set_physics_process(false) #boss cant move
		$CollisionShape2D.disabled = true #cant be damaged
		$AnimationTree.set_condition("death", true)
		game_data.dead = true
		save_data()
		
		SaveFile.game_data.positionx = SwordsMaster.global_position.x
		SaveFile.game_data.positiony = SwordsMaster.global_position.y
		SaveFile.game_data.current_lives = PlayerBasicData.current_lives
		SaveFile.game_data.current_healing = PlayerBasicData.current_healing
		SaveFile.save_data()


func _on_SlowDownTimer_timeout():
	Engine.time_scale = 1


func save_data():
	var file = File.new()
	file.open(SAVE_PATH, File.WRITE)
	file.store_var(game_data)
	file.close()

func load_data():
	var file = File.new()
	if !file.file_exists(SAVE_PATH):
		game_data = {
			"current_positionx": global_position.x,
			"current_positiony": global_position.y,
			"dead": false
		}
		save_data()
	file.open(SAVE_PATH, File.READ)
	game_data = file.get_var()
	file.close()
