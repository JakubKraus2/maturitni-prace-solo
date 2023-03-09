extends Camera2D



func _ready() -> void:
	set_process(false)

func start():
	zoom = Vector2(0.9, 0.9)
	Hud.visible = false
	HudSkill.visible = false
	$ZoomTimer.start()
	global_position.x = SwordsMaster.get_node("MainCamera").global_position.x
	current = true
	smoothing_enabled = true
	move_towards_boss()

func _process(delta: float) -> void:
	if PlayerBasicData.current_lives <= 0:
		$FightStarter.set_deferred("monitoring", true)
	zoom -= Vector2(0.001, 0.001)
	zoom.x = max(zoom.x, 0.6)
	zoom.y = max(zoom.y, 0.6)
	if current:
		SwordsMaster.attacking = true
		SwordsMaster.can_dash = false


func move_towards_boss():
	global_position.x = get_parent().position.x
	SwordsMaster.get_node("MainCamera").global_position.x = global_position.x

func _on_ZoomTimer_timeout() -> void:
	$Flash.visible = true
	$ScreenFlash.start()
	smoothing_enabled = false
	zoom = Vector2(0.6, 0.6)
	$BossName.visible = true
	$BossName.text = get_parent().boss_name
	$StopTimer.start()


func _on_StopTimer_timeout() -> void:
	$BossName.visible = false
	SwordsMaster.get_node("MainCamera").current = true
	SwordsMaster.get_node("MainCamera").global_position.x = SwordsMaster.global_position.x
	SwordsMaster.attacking = false
	SwordsMaster.can_dash = true
	get_parent().start()
	get_parent().get_node("BossHealthBar").visible = true
	Hud.visible = true
	HudSkill.visible = true
	$FightStarter.set_deferred("monitoring", false)


func _on_ScreenFlash_timeout() -> void:
	$Flash.visible = false


func _on_FightStarter_area_entered(area: Area2D) -> void:
	set_process(true)
	start()
