extends TextureButton


var artefact_name = "flash_sword"


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
		PlayerAttacksDamage.coward_sword_boost = 1
		PlayerAttacksDamage._ready()


func flash_sword():
	if PlayerBasicData.current_lives == PlayerBasicData.max_lives:
		PlayerAttacksDamage.coward_sword_boost = 1.1
		PlayerAttacksDamage._ready()
	else:
		PlayerAttacksDamage.coward_sword_boost = 1
		PlayerAttacksDamage._ready()

func _process(delta: float) -> void:
	flash_sword()
