extends CanvasLayer

onready var current_skill1 = SaveFile.game_data.current_skill1
onready var current_skill2 = SaveFile.game_data.current_skill2
onready var current_skill3 = SaveFile.game_data.current_skill3

onready var current_skill1_mana_cost = SaveFile.game_data.current_skill1_mana_cost
onready var current_skill2_mana_cost = SaveFile.game_data.current_skill2_mana_cost
onready var current_skill3_mana_cost = SaveFile.game_data.current_skill3_mana_cost

onready var current_skill1_damage = SaveFile.game_data.current_skill1_damage
onready var current_skill2_damage = SaveFile.game_data.current_skill2_damage
onready var current_skill3_damage = SaveFile.game_data.current_skill3_damage


func update_skills():
	current_skill1 = SaveFile.game_data.current_skill1
	current_skill2 = SaveFile.game_data.current_skill2
	current_skill3 = SaveFile.game_data.current_skill3

	current_skill1_mana_cost = SaveFile.game_data.current_skill1_mana_cost
	current_skill2_mana_cost = SaveFile.game_data.current_skill2_mana_cost
	current_skill3_mana_cost = SaveFile.game_data.current_skill3_mana_cost

	current_skill1_damage = SaveFile.game_data.current_skill1_damage
	current_skill2_damage = SaveFile.game_data.current_skill2_damage
	current_skill3_damage = SaveFile.game_data.current_skill3_damage


func _process(delta: float) -> void:
	if Hud.get_node("ManaBar").value < current_skill1_mana_cost && current_skill1 != "":
		$HUDSkillIcon3.modulate = Color(0.3, 0.3, 0.3)
	else:
		$HUDSkillIcon3.modulate = Color(1, 1, 1)
		
	if Hud.get_node("ManaBar").value < current_skill2_mana_cost && current_skill2 != "":
		$HUDSkillIcon2.modulate = Color(0.3, 0.3, 0.3)
	else:
		$HUDSkillIcon2.modulate = Color(1, 1, 1)
		
	if Hud.get_node("ManaBar").value < current_skill3_mana_cost && current_skill3 != "":
		$HUDSkillIcon1.modulate = Color(0.3, 0.3, 0.3)
	else:
		$HUDSkillIcon1.modulate = Color(1, 1, 1)
