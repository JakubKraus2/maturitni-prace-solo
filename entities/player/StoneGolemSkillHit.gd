extends Area2D

var attack_particle_animation = load("res://entities/player/AttackParticleAnimation.tscn")
var skill_stone_golem_explosion_spawner = load("res://entities/player/skils/SkillStoneGolemExplosionSpawner.tscn")



func _on_StoneGolemSkillHit_body_entered(body: Node) -> void:
	var attack_particle_animation_instance = attack_particle_animation.instance() #make particle spawnable
	body.get_parent().add_child(attack_particle_animation_instance) #add to root
	attack_particle_animation_instance.restart_animation(Vector2(body.position.x, get_parent().position.y)) #set its position
	
	get_parent().shake_power = 5.0 # if player hits enemy set shake_power from 0 to x
	get_parent().get_node("CameraShakeTimer").start() #start timer -> how long camera shake lasts
	body.timer.start() #starts timer in enemy script that knockbacks him
	body.modulate = Color(10, 0, 0) #change boss color after hit
	body.hurt_timer.start() #how long will the color change last
	if body.is_in_group("boss"):
		body.health_bar.set_bar_value(body.hp - PlayerAttacksDamage.stone_golem_skill_hammer) #update boss health bar
	else:
		body.aggro = true
		body.get_node("AggroRange").set_deferred("monitoring", true)
	body.hp -= PlayerAttacksDamage.stone_golem_skill_hammer



func spawn():
	var skill_stone_golem_explosion_spawner_instance = skill_stone_golem_explosion_spawner.instance()
	get_parent().add_child(skill_stone_golem_explosion_spawner_instance)
	skill_stone_golem_explosion_spawner_instance.position = get_parent().global_position
	skill_stone_golem_explosion_spawner_instance.scale.x *= -get_parent().scale.y
	get_parent().remove_child(skill_stone_golem_explosion_spawner_instance)
	get_tree().get_root().add_child(skill_stone_golem_explosion_spawner_instance)
