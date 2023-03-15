extends KinematicBody2D

export var velocity = Vector2(0,0)
export var speed = 30
export var standard_speed = 30
export var aggro_speed = 50
export var gravity = 20

export var max_knockback_power = 150
export var hp = 80
export onready var max_hp = hp

var moving_left = true

onready var timer = $KnockBackTimer
onready var animation_tree = $AnimationTree
onready var hurt_timer = $HurtTimer

var direction
onready var starting_position = global_position

export var attack_knock_back_power = 100
var attack_shake_power = 1.5

var aggro = false


func _ready() -> void:
	add_to_group("enemy")

func _physics_process(delta):
	velocity.y = velocity.y + gravity
	velocity = move_and_slide(velocity, Vector2.UP)
	direction = SwordsMaster.position.x - position.x #find player x position
	turn_around_if_hole() #first check if there is a hole
	move()
	knock_back() #check if enemy is attacked

func move():
	if aggro == true && speed != 0:
		moving_left = true if direction <= 0 else false
	velocity.x = speed if !moving_left else -speed
	scale.x = scale.y if !moving_left else -scale.y

func turn_around_if_hole():
	if !$RayCast2D.is_colliding() && is_on_floor():
		moving_left = !moving_left

func _on_CollisonDetector_body_entered(body): #check for collisions
	moving_left = !moving_left

func moving_after_attacking():
	speed = aggro_speed if $AggroRange.monitoring else standard_speed


func _on_FieldOfVision_area_entered(area: Area2D) -> void:
	$AggroRange.set_deferred("monitoring", true)
	$FieldOfVision.set_deferred("monitoring", false)
	aggro = true
	print("yes aggro")

func _on_AggroRange_area_exited(area: Area2D) -> void:
	$AggroRange.set_deferred("monitoring", false)
	$FieldOfVision.set_deferred("monitoring", true)
	aggro = false
	print("no aggro")


func death():
	if hp <= 0:
		set_physics_process(false) #enemy does not move
		$CollisionShape2D.disabled = true #cant be damaged
		$AnimationTree.set_condition("walk", false)
		$AnimationTree.set_condition("attack", false)
		$AnimationTree.set_condition("death", true)

func knock_back():
	var knockback_power = max_knockback_power if $KnockBackTimer.time_left > 0 else 0 #getting smoothly knocked back
	velocity.x += knockback_power if direction < 0 else -knockback_power #which direction to be knocked back
	death()

func _on_HurtTimer_timeout() -> void:
	modulate = Color(1, 1, 1) #boss texture goes back to normal

func deactivate_after_death():
	visible = false
	set_physics_process(false)
	set_process(false)
	$AnimationTree.active = false

func respawn():
	set_physics_process(true)
	set_process(true)
	_ready()
	visible = true
	hp = max_hp
	$AnimationTree.active = true
	$AnimationTree.set_condition("death", false)
	$CollisionShape2D.disabled = false
	global_position = starting_position
