extends Sprite

var attack_knock_back_power = 500
export var speed = 9

func _ready():
	$AnimationPlayer.play("DEFAULT")

# warning-ignore:unused_argument
func _physics_process(delta: float):
	position.x -= speed * scale.x


func _on_HitBox_area_entered(area):
	if area.get_parent().invincibility_timer.time_left == 0: #cant be damaged twice in certain period of time
		area.get_parent().attacking = true #player cant move
		area.get_parent().animation_player.play("HURT") #play hurt anim
		area.get_parent().invincibility_timer.start() #start the invincibility timer
		area.get_parent().velocity.y = -250
		PlayerBasicData.current_lives -= 1 #damage
		area.get_parent().die() #check if player is dead
		$HitBox.set_deferred("monitoring", false)
		$HitBox/CollisionShape2D.set_deferred("disabled", true)
