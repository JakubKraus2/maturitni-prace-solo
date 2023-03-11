extends TextureButton


var artefact_name = "coward_shield"

var coward_shield_barrier = load("res://entities/player/artefact_skills/CowardShieldArtefactSpawnableBarrier.tscn")

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
	if SwordsMaster.get_node("AnimationPlayer").current_animation == "HEALING" && Input.is_action_just_pressed("heal"):
		var coward_shield_barrier_instance = coward_shield_barrier.instance()
		coward_shield_barrier_instance.global_position = SwordsMaster.global_position
		get_tree().root.add_child(coward_shield_barrier_instance)
