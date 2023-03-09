extends "res://entities/enemies/EnemyParent.gd"


var projectile = load("res://entities/enemies/projectiles/Projectile.tscn")

enum {
	WALK,
	ATTACK,
	DEATH
}

var current_state = WALK


func _init() -> void:
	hp = 100
	max_knockback_power = 300
	speed = 25

func _process(delta):
	choose_state()
	match current_state:
		WALK:
			$AnimationTree.set_condition("walk", true)
		ATTACK:
			$AnimationTree.set_condition("attack", true)
		DEATH:
			$AnimationTree.set_condition("death", true)

func choose_state():
	if $PlayerDetector.get_overlapping_areas():
		current_state = ATTACK
	else:
		current_state = WALK

func spawn_projectiles():
	for i in 4: #number means number of projectiles
		var projectile_instance = projectile.instance() #make projectile spawnable object
		add_child(projectile_instance) #add as a child of enemy because of spawn point and direction
		var projectile_instance_position = projectile_instance.global_position #get its position
		remove_child(projectile_instance) #remove from enemy because of knockback caused by the player
		get_parent().add_child(projectile_instance) #add to root
		projectile_instance.position = projectile_instance_position #set old position
