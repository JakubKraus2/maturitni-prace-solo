extends Area2D



func shake_screen_anim():
	SwordsMaster.shake_power = 3.0
	SwordsMaster.get_node("CameraShakeTimer").start()
