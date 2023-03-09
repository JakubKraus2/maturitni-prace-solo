extends "res://items/item_parent.gd"


var upgrade_particle = load("res://particles/UpgradeParticle.tscn")


func mana_upgrade():
	var upgrade_particle_instance = upgrade_particle.instance()
	SwordsMaster.add_child(upgrade_particle_instance)
	Hud.get_node("ManaBar").mana_upgrade += 25
	Hud.get_node("ManaBar").upgrade_mana(Hud.get_node("ManaBar").mana_upgrade)
	save_player_data()
