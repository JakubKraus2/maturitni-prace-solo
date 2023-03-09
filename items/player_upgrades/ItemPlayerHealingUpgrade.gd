extends "res://items/item_parent.gd"


var upgrade_particle = load("res://particles/UpgradeParticle.tscn")


func heal_upgrade():
	var upgrade_particle_instance = upgrade_particle.instance()
	SwordsMaster.add_child(upgrade_particle_instance)
	Hud.get_node("Healing").upgrade_heal(1)
	save_player_data()