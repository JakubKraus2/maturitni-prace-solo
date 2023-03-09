extends CanvasLayer


onready var current_lives = $HBoxContainer/StatsUpgradesContainer2/StatsContainer/HBoxContainer/VBoxContainer2/CurrentLives
onready var current_mana = $HBoxContainer/StatsUpgradesContainer2/StatsContainer/HBoxContainer/VBoxContainer2/CurrentMana
onready var current_healing = $HBoxContainer/StatsUpgradesContainer2/StatsContainer/HBoxContainer/VBoxContainer2/CurrentHealing

onready var lives_upgrade = $HBoxContainer/StatsUpgradesContainer2/UpgradesContainer/HBoxContainer/VBoxContainer2/LivesUpgrade
onready var mana_upgrade = $HBoxContainer/StatsUpgradesContainer2/UpgradesContainer/HBoxContainer/VBoxContainer2/ManaUpgrade
onready var healing_upgrade = $HBoxContainer/StatsUpgradesContainer2/UpgradesContainer/HBoxContainer/VBoxContainer2/HealingUpgrade
onready var damage_upgrade = $HBoxContainer/StatsUpgradesContainer2/UpgradesContainer/HBoxContainer/VBoxContainer2/DamageUpgrade

onready var skill1 = $HBoxContainer/SkillsArtefactsContainer/SkillsContainer/HBoxContainer/Skill1
onready var skill2 = $HBoxContainer/SkillsArtefactsContainer/SkillsContainer/HBoxContainer/Skill2
onready var skill3 = $HBoxContainer/SkillsArtefactsContainer/SkillsContainer/HBoxContainer/Skill3

onready var Artefact1 = $HBoxContainer/SkillsArtefactsContainer/ArtefactsContainer/HBoxContainer/Artefact1
onready var Artefact2 = $HBoxContainer/SkillsArtefactsContainer/ArtefactsContainer/HBoxContainer/Artefact2
onready var Artefact3 = $HBoxContainer/SkillsArtefactsContainer/ArtefactsContainer/HBoxContainer/Artefact3
onready var Artefact4 = $HBoxContainer/SkillsArtefactsContainer/ArtefactsContainer/HBoxContainer/Artefact4

onready var attack_power1 = $HBoxContainer/AttackPowerContainer/AttackPowerContainer2/AttackContainer/HBoxContainer/VBoxContainer2/AttackPower1
onready var attack_power2 = $HBoxContainer/AttackPowerContainer/AttackPowerContainer2/AttackContainer/HBoxContainer/VBoxContainer2/AttackPower2
onready var attack_power3 = $HBoxContainer/AttackPowerContainer/AttackPowerContainer2/AttackContainer/HBoxContainer/VBoxContainer2/AttackPower3

onready var attack_power_skill1 = $HBoxContainer/AttackPowerContainer/AttackPowerContainer2/StatsContainer/HBoxContainer/VBoxContainer2/AttackPowerSkill1
onready var attack_power_skill2 = $HBoxContainer/AttackPowerContainer/AttackPowerContainer2/StatsContainer/HBoxContainer/VBoxContainer2/AttackPowerSkill2
onready var attack_power_skill3 = $HBoxContainer/AttackPowerContainer/AttackPowerContainer2/StatsContainer/HBoxContainer/VBoxContainer2/AttackPowerSkill3


func update_stats() -> void:
	current_lives.text = str(PlayerBasicData.current_lives, "/", PlayerBasicData.max_lives)
	current_mana.text = str(floor(PlayerBasicData.current_mana*Hud.get_node("ManaBar").mana_ring), "/", floor(PlayerBasicData.max_mana*Hud.get_node("ManaBar").mana_ring))
	current_healing.text = str(PlayerBasicData.current_healing, "/", PlayerBasicData.max_healing)
	
	lives_upgrade.text = str("+", PlayerBasicData.max_lives - 5)
	mana_upgrade.text = str("+", floor(PlayerBasicData.max_mana - 100))
	healing_upgrade.text = str("+", PlayerBasicData.max_healing - 3)
	damage_upgrade.text = str("+", floor((PlayerAttacksDamage.damage_upgrade - 1) * 100), "%")
	
	skill1.texture = load(SpecialSkillMenu.skills.current_skill1_texture_normal)
	skill2.texture = load(SpecialSkillMenu.skills.current_skill2_texture_normal)
	skill3.texture = load(SpecialSkillMenu.skills.current_skill3_texture_normal)

	Artefact1.texture = load(ArtefactMenu.artefacts.current_artefact1_texture_normal)
	Artefact2.texture = load(ArtefactMenu.artefacts.current_artefact2_texture_normal)
	Artefact3.texture = load(ArtefactMenu.artefacts.current_artefact3_texture_normal)
	Artefact4.texture = load(ArtefactMenu.artefacts.current_artefact4_texture_normal)
	
	attack_power1.text = str(floor(PlayerAttacksDamage.slash_damage), "\n", floor(PlayerAttacksDamage.slash_damage_mana_gain))
	attack_power2.text = str(floor(PlayerAttacksDamage.slash_damage), "\n", floor(PlayerAttacksDamage.slash_damage_mana_gain))
	attack_power3.text = str(floor(PlayerAttacksDamage.crusher_damage), "\n", floor(PlayerAttacksDamage.crusher_damage_mana_gain))
	
	attack_power_skill1.text = str(floor(HudSkill.current_skill1_damage*PlayerAttacksDamage.damage_upgrade*PlayerAttacksDamage.coward_sword_boost), "\n", HudSkill.current_skill1_mana_cost)
	attack_power_skill2.text = str(floor(HudSkill.current_skill2_damage*PlayerAttacksDamage.damage_upgrade*PlayerAttacksDamage.coward_sword_boost), "\n", HudSkill.current_skill2_mana_cost)
	attack_power_skill3.text = str(floor(HudSkill.current_skill3_damage*PlayerAttacksDamage.damage_upgrade*PlayerAttacksDamage.coward_sword_boost), "\n", HudSkill.current_skill3_mana_cost)
