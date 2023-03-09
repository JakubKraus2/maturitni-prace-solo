extends Node2D


var skill_stone_golem_explosion = load("res://entities/player/skils/SkillStoneGolemExplosion.tscn")


var spawn_count = 0
var finished_count = 0

const OFFSET = 40


func _on_SpawnTimer_timeout():
	if spawn_count < 3:
		spawn()
	if finished_count >= 3:
		queue_free()

func spawn():
	spawn_count += 1
	var skill_stone_golem_explosion_instance = skill_stone_golem_explosion.instance()
	add_child(skill_stone_golem_explosion_instance)
	skill_stone_golem_explosion_instance.position.x += OFFSET*spawn_count
