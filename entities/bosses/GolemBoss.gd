extends "res://entities/bosses/BossParent.gd"

#if player is behind the boss, the boss will JUMP_ATTACK and turn himself to the player
#if player is infront of the boss, the boss will do SMASH_ATTACK
#after ~50% hp the boss will start doing DOUBLE_SMASH

enum { #define all states boss can be in
	IDLE
	SMASH
	JUMP
	DEATH
	SECOND_PHASE_ATTACK
}

const boss_name = "Stone Golem"

var melee_projectile_spawner = load("res://entities/bosses/projectiles/GolemBossMeleeProjectileSpawner.tscn")
var jump_projectile = load("res://entities/bosses/projectiles/GolemBossJumpProjectile.tscn")
var second_phase_stone_projectile = load("res://entities/bosses/projectiles/GolemBossStoneProjectile.tscn")

var item_drop = load("res://items/bosses/ItemStoneGolem.tscn")

var current_state = IDLE

var second_phase_attack

func _init(): #change parameters from parent
	hp = 700
	max_hp = hp
	max_knockback_power = 25

func _ready() -> void: #boss is in idle state until bossfight starts
	if game_data.dead == true:
		queue_free()
	current_state = IDLE
	$AnimationTree.set_condition("idle", true)
	$AnimationTree.set_condition("second_phase_attack", false)
	$AnimationTree.set_condition("jump", false)
	$AnimationTree.set_condition("smash_attack", false)
	second_phase_attack = true
	set_process(false)


func _process(delta):
	choose_state() #choose what state boss is in
	match current_state:
		IDLE: #boss does nothing
			$AnimationTree.set_condition("idle", true)
		SMASH: #boss smashes down
			$AnimationTree.set_condition("smash_attack", true)
		JUMP: #boss jumps
			$AnimationTree.set_condition("jump", true)
		SECOND_PHASE_ATTACK:
			$AnimationTree.set_condition("second_phase_attack", true)
		DEATH: #boss dies
			$AnimationTree.set_condition("death", true)
		_: #default
			$AnimationTree.set_condition("idle", true)


func start(): #start the boss
	set_process(true)

func choose_state(): #choose what state boss is in
	if hp <= max_hp/2 && second_phase_attack: #if hp is around 50% and boss can do his special 2nd phase attack
		current_state = SECOND_PHASE_ATTACK #do the attack
		second_phase_attack = false #cant do him anymore
	else:
		if moving_left && direction > 0 || !moving_left && direction <= 0: #if boss is not facing the player
			current_state = JUMP #JUMP and reposition
		else:
			current_state = SMASH #SMASH otherwise


#FUNCTIONS FOR JUMP_ATTACK
func jump(): #JUMP - see AnimationPlayer
	velocity.y = -600 #jump height
	speed = direction*0.75 #jump width

func jump_anim(): #called at the end of jump animation -> see AnimationPlayer
	scale.x = -scale.x
	moving_left = !moving_left

func spawn_jump_projectiles():
	var jump_projectile_instance = jump_projectile.instance()
	get_parent().add_child(jump_projectile_instance)
	jump_projectile_instance.position = Vector2(position.x, position.y)
	var jump_projectile_instance2 = jump_projectile.instance()
	get_parent().add_child(jump_projectile_instance2)
	jump_projectile_instance2.position = Vector2(position.x, position.y)
	jump_projectile_instance2.scale.x = -0.5


#FUNCTIONS FOR SMASH_ATTACK
func spawn_melee_projectiles():
	var melee_projectile_spawner_instance = melee_projectile_spawner.instance()
	get_parent().add_child(melee_projectile_spawner_instance)
	melee_projectile_spawner_instance.position = Vector2(position.x, position.y + $Sprite.get_rect().size.y)
	melee_projectile_spawner_instance.scale.x = -1 if moving_left else 1


#FUNCTIONS FOR SECOND_PHASE_ATTACK
func second_phase_attack_facing():
	if is_processing():
		scale.x = -scale.x
		moving_left = !moving_left

func spawn_stone_projectiles():
	if is_processing():
		for i in 3:
			var second_phase_stone_projectile_instance = second_phase_stone_projectile.instance()
			get_parent().add_child(second_phase_stone_projectile_instance)
			second_phase_stone_projectile_instance.position = Vector2(rand_range(SwordsMaster.position.x - 480, SwordsMaster.position.x + 480), rand_range(0, -1024))

#OTHER
func shake_screen_anim():
	if is_processing():
		SwordsMaster.shake_power = 2.5
		SwordsMaster.get_node("CameraShakeTimer").start()

func disable_all():
	SwordsMaster.get_node("MainCamera").current = true
	get_node("BossHealthBar").queue_free()
	$JumpAttackHitbox/CollisionShape2D.disabled = true
	$SmashAttackHitbox/CollisionShape2D.disabled = true
	$SecondPhazeAttackHitBox/CollisionShape2D.disabled = true

func spawn_item():
	var item_drop_instance = item_drop.instance()
	get_parent().add_child(item_drop_instance)
	item_drop_instance.global_position = global_position
