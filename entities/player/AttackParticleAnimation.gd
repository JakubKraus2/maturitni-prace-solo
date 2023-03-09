extends Sprite


func restart_animation(new_position):
	global_position = new_position
	$AnimationPlayer.play("DEFAULT")
