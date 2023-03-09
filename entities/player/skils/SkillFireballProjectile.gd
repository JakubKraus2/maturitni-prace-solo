extends KinematicBody2D


var speed = -500
var velocity = Vector2.ZERO


func _ready() -> void:
	velocity.x = speed * SwordsMaster.scale.y
	scale.x = -SwordsMaster.scale.y
	$AnimationPlayer.play("DEFAULT")

func _process(delta: float) -> void:
	move_and_slide(velocity, Vector2.UP)


func _on_SkillFireballProjectileHitbox_body_entered(body: Node) -> void:
	body.timer.start() #starts timer in enemy script that knockbacks him
	body.modulate = Color(10, 0, 0) #change boss color after hit
	body.hurt_timer.start() #how long will the color change last
	if body.is_in_group("boss"):
		body.health_bar.set_bar_value(body.hp - PlayerAttacksDamage.fireball_skill) #update boss health bar
	else:
		body.aggro = true
		body.get_node("AggroRange").set_deferred("monitoring", true)
	body.hp -= PlayerAttacksDamage.fireball_skill


func _on_Timer_timeout() -> void:
	queue_free()
