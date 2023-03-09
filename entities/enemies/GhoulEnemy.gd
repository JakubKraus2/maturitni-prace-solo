extends "res://entities/enemies/EnemyParent.gd"

#nodes needed: PlayerChaser, PlayerDetector, CollisionDetector, HitDetector, RayCast2D, KnockBackTimer, AnimationPlayer
#animations needed: HURT, WALK, DEATH, ATTACK

#can change: speed (defalut 100)
#            knockback_power (default 800)
#            hp (default 80)
#            attack_knock_back_power (default 250)

enum {
	WALK,
	ATTACK,
	DEATH
}

var current_state = WALK

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

func _on_HitDetector_area_entered(area: Area2D) -> void:
	if SwordsMaster.invincibility_timer.time_left == 0:
		SwordsMaster.attacking = true
		SwordsMaster.animation_player.play("HURT")
		SwordsMaster.invincibility_timer.start()
		PlayerBasicData.current_lives -= 1
		SwordsMaster.die()
		print("hit")

