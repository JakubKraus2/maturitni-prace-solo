extends Area2D

var attack_particle_animation = load("res://entities/player/AttackParticleAnimation.tscn")


func _on_RollAttackHit_body_entered(body):
	var attack_particle_animation_instance = attack_particle_animation.instance() #make particle spawnable
	body.get_parent().add_child(attack_particle_animation_instance) #add to root
	attack_particle_animation_instance.restart_animation(Vector2(body.position.x, get_parent().position.y)) #set its position
	
	get_parent().shake_power = 3.0 # if player hits enemy set shake_power from 0 to x
	get_parent().get_node("CameraShakeTimer").start() #start timer -> how long camera shake lasts
	body.timer.start() #starts timer in enemy script that knockbacks him
	if body.is_in_group("boss"):
		body.modulate = Color(255, 0, 0)
		body.hurt_timer.start()
	else:
		body.animation_player.play("HURT") #enemy will play hurt animation
	body.hp -= PlayerAttacksDamage.roll_attack_damage
