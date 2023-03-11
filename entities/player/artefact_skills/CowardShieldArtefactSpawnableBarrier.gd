extends Node2D


func _ready() -> void:
	$AnimationPlayer.play("DEFAULT")

func set_camera_shake(var shake_power):
	SwordsMaster.shake_power = shake_power

func set_player_invincibility(var is_disabled):
	SwordsMaster.get_node("HitBox/CollisionShape2D").disabled = is_disabled
