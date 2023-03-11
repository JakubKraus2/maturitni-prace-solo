extends TextureButton

var cooldown = true
var artefact_name = "thorned_rose"
var thorned_rose_projectile_spawner = load("res://entities/player/artefact_skills/ThornedRoseArtefactThornProjectile.tscn")

func _ready() -> void:
	set_process(false)

func boost():
	if $"../..".artefacts.current_artefact1_artefact_name == artefact_name:
		set_process(true)
	elif $"../..".artefacts.current_artefact2_artefact_name == artefact_name:
		set_process(true)
	elif $"../..".artefacts.current_artefact3_artefact_name == artefact_name:
		set_process(true)
	elif $"../..".artefacts.current_artefact4_artefact_name == artefact_name:
		set_process(true)
	else:
		set_process(false)


func _process(delta: float) -> void:
	if SwordsMaster.get_node("AnimationPlayer").current_animation == "HURT" && cooldown == true:
		var thorned_rose_projectile_spawner_instance = thorned_rose_projectile_spawner.instance()
		thorned_rose_projectile_spawner_instance.global_position = SwordsMaster.global_position
		get_tree().root.add_child(thorned_rose_projectile_spawner_instance)
		cooldown = false


func _on_ThornedRoseCooldown_timeout() -> void:
	cooldown = true
