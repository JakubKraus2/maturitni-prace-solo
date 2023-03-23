extends Area2D


onready var game_data = SaveFile.game_data


func _ready() -> void:
	$AnimationPlayer.play("DEFAULT")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") && get_overlapping_areas() && game_data.can_double_jump == false:
		game_data.can_double_jump = true
		SaveFile.save_data()
		$UnlockParticle.emitting = true
		$UnlockParticle.get_node("DeleteTimer").start()
		$UnlockParticle.get_node("StopShakeTimer").start()
		$UnlockParticle.global_position = SwordsMaster.global_position
		SwordsMaster.attacking = true
		SwordsMaster.can_dash = false
		SwordsMaster.shake_power = 0.5


func _on_Unlocker_area_entered(area):
	if game_data.can_double_jump == false:
		$PickText.visible = true

func _on_Unlocker_area_exited(area):
	$PickText.visible = false
