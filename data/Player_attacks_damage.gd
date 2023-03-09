extends Node2D


onready var damage_upgrade = SaveFile.game_data.damage_upgrade
var executioner_sword_boost = 1
var coward_sword_boost = 1

var slash_damage = 20
var crusher_damage = 30
var spin_slash_damage = 30
var falling_attack_damage = 10
var roll_attack_damage = 10

var slash_damage_mana_gain = slash_damage/10
var crusher_damage_mana_gain = crusher_damage/10
var spin_slash_damage_mana_gain = spin_slash_damage/10
var falling_attack_damage_mana_gain = falling_attack_damage/10
var roll_attack_damage_mana_gain = roll_attack_damage/10

var stone_golem_skill_hammer = 60
var stone_golem_skill_hammer_eplosion = 30

var fireball_skill = 40

func _ready() -> void:
	slash_damage = 20 * damage_upgrade * executioner_sword_boost * coward_sword_boost
	crusher_damage = 30 * damage_upgrade * executioner_sword_boost * coward_sword_boost
	spin_slash_damage = 30 * damage_upgrade * executioner_sword_boost * coward_sword_boost
	falling_attack_damage = 10 * damage_upgrade * executioner_sword_boost * coward_sword_boost
	roll_attack_damage = 10 * damage_upgrade * executioner_sword_boost * coward_sword_boost

	slash_damage_mana_gain = slash_damage/10
	crusher_damage_mana_gain = crusher_damage/10
	spin_slash_damage_mana_gain = spin_slash_damage/10
	falling_attack_damage_mana_gain = falling_attack_damage/10
	roll_attack_damage_mana_gain = roll_attack_damage/10

	stone_golem_skill_hammer = 60 * damage_upgrade * executioner_sword_boost * coward_sword_boost
	stone_golem_skill_hammer_eplosion = 30 * damage_upgrade * executioner_sword_boost * coward_sword_boost
	fireball_skill = 40 * damage_upgrade * executioner_sword_boost * coward_sword_boost
