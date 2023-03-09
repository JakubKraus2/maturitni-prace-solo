extends Sprite

var attack_knock_back_power = 400

func _ready() -> void:
	$AnimationPlayer.play("DEFAULT")

func add_to_finished_count():
	get_parent().finished_count += 1


func _on_HitBox_area_entered(area: Area2D) -> void:
	if area.get_parent().invincibility_timer.time_left == 0: #cant be damaged twice in certain period of time
		area.get_parent().attacking = true #player cant move
		area.get_parent().animation_player.play("HURT") #play hurt anim
		area.get_parent().invincibility_timer.start() #start the invincibility timer
		area.get_parent().velocity.y = -300
		PlayerBasicData.current_lives -= 1 #damage
		area.get_parent().die() #check if player is dead
