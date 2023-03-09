extends KinematicBody2D

var is_moving_left = true

var gravity = 10
var velocity = Vector2(0,0)

var speed = 20

func _ready():
	$AnimationPlayer.play("IDLE")

func _process(delta):
	move()
	turn_around()
	
func move():
	velocity.x = -speed if is_moving_left else speed
	velocity.y += gravity
	
	velocity = move_and_slide(velocity, Vector2.UP)

func turn_around():
	if not $RayCast2D.is_colliding() && is_on_floor():
		is_moving_left =!is_moving_left
		scale.x = -scale.x
