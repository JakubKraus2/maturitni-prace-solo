extends Sprite


var attack_knock_back_power = 200


func _ready():
	$AnimationPlayer.play("SPAWN")

func set_camera_shake(var shake_power):
	SwordsMaster.shake_power = shake_power


func _on_HeartHorderPillarAttackHitbox_area_entered(area: Area2D) -> void:
	if area.get_parent().invincibility_timer.time_left == 0: #cant be damaged twice in certain period of time
		area.get_parent().attacking = true #player cant move
		area.get_parent().animation_player.play("HURT") #play hurt anim
		area.get_parent().invincibility_timer.start() #start the invincibility timer
		area.get_parent().velocity.y = -250
		PlayerBasicData.current_lives -= 1 #damage
		area.get_parent().die() #check if player is dead
