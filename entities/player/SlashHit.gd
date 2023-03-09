extends Area2D

var attack_particle_animation = load("res://entities/player/AttackParticleAnimation.tscn")


func _on_SlashHit_body_entered(body): #body = the thing that is getting hit
	var attack_particle_animation_instance = attack_particle_animation.instance() #make particle spawnable
	body.get_parent().add_child(attack_particle_animation_instance) #add to root
	attack_particle_animation_instance.restart_animation(Vector2(body.global_position.x, get_parent().global_position.y)) #set its position
	
	get_parent().shake_power = 1.5 # if player hits enemy set shake_power from 0 to x
	get_parent().get_node("CameraShakeTimer").start() #start timer -> how long camera shake lasts
	body.timer.start() #starts timer in enemy script that knockbacks him
	body.modulate = Color(10, 0, 0) #change boss color after hit
	body.hurt_timer.start() #how long will the color change last
	if body.is_in_group("boss"):
		body.health_bar.set_bar_value(body.hp - PlayerAttacksDamage.slash_damage) #update boss health bar
	else:
		body.aggro = true
		body.get_node("AggroRange").set_deferred("monitoring", true)
	body.hp -= PlayerAttacksDamage.slash_damage
	Hud.get_node("ManaBar").set_bar_value(Hud.get_node("ManaBar").value + PlayerAttacksDamage.slash_damage_mana_gain)
