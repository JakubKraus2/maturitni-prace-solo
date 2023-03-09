extends Area2D

var attack_shake_power = 5.0


func _on_JumpAttackHitbox_area_entered(area):
	if area.get_parent().invincibility_timer.time_left == 0: #cant be damaged twice in certain period of time
		area.get_parent().attacking = true #player cant move
		area.get_parent().animation_player.play("HURT") #play hurt anim
		area.get_parent().invincibility_timer.start() #start the invincibility timer
		PlayerBasicData.current_lives -= 1 #damage
		area.get_parent().die() #check if player is dead
