extends Area2D



func _on_ThornedRoseHitbox_body_entered(body: Node) -> void:
	body.modulate = Color(10, 0, 0) #change boss color after hit
	body.hurt_timer.start() #how long will the color change last
	if body.is_in_group("boss"):
		body.health_bar.set_bar_value(body.hp - PlayerAttacksDamage.thorned_rose_projectile) #update boss health bar
	else:
		body.aggro = true
		body.get_node("AggroRange").set_deferred("monitoring", true)
	body.hp -= PlayerAttacksDamage.thorned_rose_projectile
	get_parent().queue_free()
