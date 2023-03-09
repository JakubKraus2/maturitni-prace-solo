extends Node2D


var boss_attack_projectile = load("res://entities/bosses/projectiles/GolemBossMeleeProjectile.tscn")
var spawn_count = 0
var finished_count = 0

func _on_SpawnTimer_timeout():
	if spawn_count < 4:
		spawn()
	if finished_count >= 4:
		queue_free()

func spawn():
	spawn_count += 1
	var boss_attack_projectile_instance = boss_attack_projectile.instance()
	add_child(boss_attack_projectile_instance)
	boss_attack_projectile_instance.position.x += (boss_attack_projectile_instance.get_rect().size.x*0.666) * (get_child_count()-1)
