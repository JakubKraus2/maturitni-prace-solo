extends Sprite



func delete():
	SwordsMaster.attacking = false
	SwordsMaster.can_dash = true
	get_parent().queue_free()
	get_parent().get_parent().get_node("UnlockPopup").play()

func increase_shake_power():
	SwordsMaster.shake_power = 3.0

func decrease_shake_power():
	SwordsMaster.shake_power = 0.0
