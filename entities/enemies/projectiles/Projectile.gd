extends KinematicBody2D

const gravity = 20
var velocity = Vector2.ZERO
var speed = rand_range(60.0, 180.0) #how far
var hop_force = rand_range(-300.0, -450.0) #what height

export var attack_knock_back_power = 40


func _ready() -> void:
	speed = -speed if get_parent().moving_left else speed
	$AnimationPlayer.play("MOVING")
	spawn()

func _physics_process(delta: float) -> void:
	if velocity.y == 0:
		explosion()
		set_physics_process(false)
	movement()

func movement():
	velocity.y = velocity.y + gravity
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x += speed
	velocity.x = lerp(velocity.x,0,0.5)

func spawn():
	velocity.y = hop_force

func _on_PlayerDetector_area_entered(area: Area2D) -> void:
	if SwordsMaster.invincibility_timer.time_left == 0:
		SwordsMaster.attacking = true
		SwordsMaster.animation_player.play("HURT")
		SwordsMaster.invincibility_timer.start()
		PlayerBasicData.current_lives -= 1
		SwordsMaster.die()
		print("hit")
	set_physics_process(false)
	$AnimationPlayer.play("EXPLOSION")

func explosion():
	$AnimationPlayer.play("EXPLOSION_2")
