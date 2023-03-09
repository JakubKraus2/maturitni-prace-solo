extends "res://items/item_parent.gd"


var upgrade_particle = load("res://particles/UpgradeParticle.tscn")


func upgrade_damage():
	var upgrade_particle_instance = upgrade_particle.instance()
	SwordsMaster.add_child(upgrade_particle_instance)
	PlayerAttacksDamage.damage_upgrade += 0.2
	save_player_data()
	PlayerAttacksDamage._ready()
