extends Particles2D



func _on_DeleteTimer_timeout() -> void:
	$BigCircle.visible = true
	$BigCircle/AnimationPlayer.play("DEFAULT")

func _on_StopShakeTimer_timeout() -> void:
	SwordsMaster.shake_power = 0.0
