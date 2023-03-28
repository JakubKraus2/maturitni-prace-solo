extends Area2D



func _ready() -> void:
	$AnimationPlayer.play("DEFAULT")
	$StoneGolemSkillSound.play()

func add_to_finished_count():
	yield($StoneGolemSkillSound, "finished")
	get_parent().finished_count += 1
	queue_free()


func _on_SkillStoneGolemExplosion_body_entered(body: Node) -> void:
	body.timer.start() #starts timer in enemy script that knockbacks him
	body.modulate = Color(10, 0, 0) #change boss color after hit
	body.hurt_timer.start() #how long will the color change last
	if body.is_in_group("boss"):
		body.health_bar.set_bar_value(body.hp - PlayerAttacksDamage.slash_damage) #update boss health bar
	else:
		body.aggro = true
		body.get_node("AggroRange").set_deferred("monitoring", true)
	body.hp -= PlayerAttacksDamage.stone_golem_skill_hammer_eplosion
