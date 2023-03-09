extends KinematicBody2D


var speed_x = 0
var speed_y = 0.5
var velocity = Vector2.ZERO

var attack_knock_back_power = 200

var moving_left = false


func _ready() -> void:
	$AnimationPlayer.play("DEFAULT")

func _physics_process(delta: float) -> void:
	velocity.y += speed_y
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = speed_x
	if speed_x >= 300 || speed_x <= -300:
		moving_left = !moving_left
	if moving_left == true:
		speed_x -= 5
	if moving_left == false:
		speed_x += 5


func _on_Hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent().invincibility_timer.time_left == 0: #cant be damaged twice in certain period of time
		area.get_parent().attacking = true #player cant move
		area.get_parent().animation_player.play("HURT") #play hurt anim
		area.get_parent().invincibility_timer.start() #start the invincibility timer
		PlayerBasicData.current_lives -= 1 #damage
		area.get_parent().die() #check if player is dead


func _on_DeleteTimer_timeout() -> void:
	queue_free()
