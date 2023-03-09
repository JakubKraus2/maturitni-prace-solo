extends TextureButton


var artefact_name = "executioner_sword"


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


func executioner_sword():
	if PlayerBasicData.current_lives == 1:
		PlayerAttacksDamage.executioner_sword_boost = 1.3
		PlayerAttacksDamage._ready()
	else:
		PlayerAttacksDamage.executioner_sword_boost = 1
		PlayerAttacksDamage._ready()

func _process(delta: float) -> void:
	executioner_sword()
