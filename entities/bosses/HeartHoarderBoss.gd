extends "res://entities/bosses/BossParent.gd"

#movement = porting
#after every port boss will strike with random attack or port again
#attacks: running attack, homing swords, falling attack, summon lasers from ground, boomerang swords

enum { #define all states boss can be in
	IDLE
	IDLE_START
	PORT
	SPAWN_SWORD_ATTACK
	RUNNING_ATTACK
	SPAWN_PILLAR_ATTACK
	FALL_ATTACK
	BOOMERANG_ATTACK
	STAGGER
	DEATH
}

const boss_name = "Heart Hoarder"

var sword_projectile = load("res://entities/bosses/projectiles/HeartHorderSwordProjectile.tscn")
var pillar_attack_projectile = load("res://entities/bosses/projectiles/HeartHorderPillarsAttackProjectile.tscn")
var boomerang_attack_projectile = load("res://entities/bosses/projectiles/HeartHorderBoomerangAttack.tscn")

var item_drop = load("res://items/bosses/ItemFireballSkill.tscn")

export var current_state = PORT

var stagger1 = true


func start():
	set_process(true)
	current_state = PORT

func _init(): #change parameters from parent
	hp = 1200
	max_hp = hp
	max_knockback_power = 25
	gravity = 0


func _ready() -> void:
	if game_data.dead == true:
		queue_free()
	$AnimationTree.set_condition("idle_start", true)
	disable_all_conditions()
	stagger1 = true
	set_process(false)

func _process(delta):
	check_stagger()
	match current_state:
		IDLE: #boss does nothing
			$AnimationTree.set_condition("idle", true)
		IDLE_START:
			$AnimationTree.set_condition("idle_start", true)
		PORT:
			$AnimationTree.set_condition("port_out", true)
		SPAWN_SWORD_ATTACK:
			$AnimationTree.set_condition("spawn_sword_attack", true)
		RUNNING_ATTACK:
			$AnimationTree.set_condition("running_attack", true)
		FALL_ATTACK:
			$AnimationTree.set_condition("fall_attack", true)
		SPAWN_PILLAR_ATTACK:
			$AnimationTree.set_condition("spawn_pillars_attack", true)
		BOOMERANG_ATTACK:
			$AnimationTree.set_condition("boomerang_attack", true)
		STAGGER:
			disable_all_conditions()
			$AnimationTree.set_condition("stagger", true)
		DEATH: #boss dies
			$AnimationTree.set_condition("death", true)
		_: #default
			$AnimationTree.set_condition("idle", true)

func choose_state():
	var state_chooser = randi()%19+1 #random number from 1 to 4
	print(state_chooser)
	match state_chooser:
		0, 1, 2, 3:
			current_state = PORT
			print("port")
		4, 5, 6, 7, 8:
			current_state = SPAWN_SWORD_ATTACK
			print("spawn_sword_attack")
		9, 10, 11:
			current_state = SPAWN_PILLAR_ATTACK
			print("spawn_pillars_attack")
		12, 13, 14:
			current_state = FALL_ATTACK
			print("fall_attack")
		15, 16:
			current_state = RUNNING_ATTACK
			print("running_attack")
		17, 18, 19:
			current_state = BOOMERANG_ATTACK
			print("boomerang_attack")
		_:
			current_state = PORT
			print("default")


func check_stagger():
	if hp <= (max_hp/100)*65 && hp > 0 && stagger1:
		current_state = STAGGER
		stagger1 = false

func start_second_phase():
	get_parent().get_node("HeartHoarderBoss2").start()
	get_parent().get_node("HeartHoarderBoss2").global_position = global_position

func teleport():
	print(current_state)
	match current_state:
		RUNNING_ATTACK:
			running_attack_teleport()
		SPAWN_PILLAR_ATTACK:
			spawn_pillars_attack_teleport()
		FALL_ATTACK:
			fall_attack_teleport()
		BOOMERANG_ATTACK:
			boomerang_attack_teleport()
		_:
			global_position = Vector2(rand_range(64, 615), rand_range(90, 220))

func running_attack_teleport():
	global_position = Vector2(64, 250)

func spawn_pillars_attack_teleport():
	global_position = Vector2(320, 160)

func fall_attack_teleport():
	global_position = Vector2(SwordsMaster.global_position.x, 153)

func boomerang_attack_teleport():
	global_position = Vector2(320, 100)

func stagger_teleport():
	global_position = Vector2(300, 240)

func second_phase_transition():
	global_position = Vector2(300, 100)


func spawn_swords():
	for i in 4:
		var sword_projectile_instance = sword_projectile.instance()
		match i:
			0:
				sword_projectile_instance.global_position = Vector2(global_position.x-52, global_position.y-24)
			1:
				sword_projectile_instance.global_position = Vector2(global_position.x-28, global_position.y-64)
			2:
				sword_projectile_instance.global_position = Vector2(global_position.x+28, global_position.y-64)
			3:
				sword_projectile_instance.global_position = Vector2(global_position.x+52, global_position.y-24)
		get_parent().add_child(sword_projectile_instance)
		yield(get_tree().create_timer(0.3), "timeout")


func spawn_pillars():
	for i in 7:
		yield(get_tree().create_timer(0.1), "timeout")
		var pillar_attack_projectile_instance = pillar_attack_projectile.instance()
		pillar_attack_projectile_instance.global_position = Vector2(80 + (i*90), 335)
		get_parent().add_child(pillar_attack_projectile_instance)


func spawn_boomerangs():
	for i in 2:
		var boomerang_attack_projectile_instance = boomerang_attack_projectile.instance()
		boomerang_attack_projectile_instance.moving_left = false
		var boomerang_attack_projectile_instance2 = boomerang_attack_projectile.instance()
		boomerang_attack_projectile_instance2.moving_left = true
		match i:
			0:
				boomerang_attack_projectile_instance.global_position = Vector2(global_position.x-48, global_position.y+48)
				boomerang_attack_projectile_instance2.global_position = Vector2(global_position.x+48, global_position.y+48)
			1:
				boomerang_attack_projectile_instance.global_position = Vector2(global_position.x-55, global_position.y+64)
				boomerang_attack_projectile_instance2.global_position = Vector2(global_position.x+55, global_position.y+64)
		get_parent().add_child(boomerang_attack_projectile_instance)
		get_parent().add_child(boomerang_attack_projectile_instance2)
		yield(get_tree().create_timer(0.4), "timeout")


func disable_all_conditions():
	$AnimationTree.set_condition("port_out", false)
	$AnimationTree.set_condition("spawn_sword_attack", false)
	$AnimationTree.set_condition("running_attack", false)
	$AnimationTree.set_condition("fall_attack", false)
	$AnimationTree.set_condition("spawn_pillars_attack", false)
	$AnimationTree.set_condition("boomerang_attack", false)
	$AnimationTree.set_condition("stagger", false)
	$AnimationTree.set_condition("idle", false)

func spawn_item():
	var item_drop_instance = item_drop.instance()
	get_parent().add_child(item_drop_instance)
	item_drop_instance.global_position = Vector2(global_position.x, global_position.y + 48)

func disable_all():
	SwordsMaster.get_node("MainCamera").current = true
	get_node("BossHealthBar").queue_free()
	$RunningAttackHitbox/CollisionShape2D.disabled = true

func set_camera_shake(var shake_power):
	SwordsMaster.shake_power = shake_power

func set_game_speed(var game_speed):
	Engine.time_scale = game_speed

func stop_second_phase_after_death():
	$"2ndPhaseHitbox".queue_free()
	get_parent().get_node("HeartHoarderBoss2").queue_free()
