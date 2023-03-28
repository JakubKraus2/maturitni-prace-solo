extends KinematicBody2D


signal grounded_updated(is_grounded)

onready var game_data = SaveFile.game_data

var velocity = Vector2(0,0)
const speed = 100
const dash_speed = 200
var idol_of_haste_boost = 1
const gravity = 20
const jumpforce = -450

var double_jump = false

export var attacking = false #attacking or dashing
export var combo = 1

export var can_dash = true

export var shake_power = 0.0 #see more in all attacks in Area2D's
var enemy_attack_knock_back_power
var enemy_direction

onready var invincibility_timer = $Invincibility_timer
onready var animation_player = $AnimationPlayer

var is_grounded
var was_grounded

var double_jump_particle = load("res://particles/DoubleJumpParticle.tscn")
var wall_slide_particle = load("res://particles/WallSlideParticle.tscn")
var run_particle = load("res://particles/RunParticle.tscn")
var jump_land_particle = load("res://particles/JumpLandParticle.tscn")

var fireball = load("res://entities/player/skils/SkillFireballProjectile.tscn")


func _ready() -> void:
	var file = File.new()
	if file.file_exists(SaveFile.SAVE_PATH):
		global_position.x = game_data.positionx
		global_position.y = game_data.positiony
	else:
		global_position.x = 0
		global_position.y = 0

func get_movement_input():
	if Input.is_action_pressed("ui_right") && $AnimationPlayer.current_animation != "DASH": #if you press right and are not attacking
		if !is_on_floor() && velocity.y != gravity:
			velocity.x += speed * idol_of_haste_boost
			scale.x = -scale.y
		elif !attacking && can_dash:
			velocity.x += speed * idol_of_haste_boost
			scale.x = -scale.y
			combo = 1
			$AnimationPlayer.play("RUN2")
		
	if Input.is_action_pressed("ui_left") && $AnimationPlayer.current_animation != "DASH": #if you press left and are not attacking
		if !is_on_floor() && velocity.y != gravity:
			velocity.x -= speed * idol_of_haste_boost
			scale.x = scale.y
		elif !attacking && can_dash:
			velocity.x -= speed * idol_of_haste_boost
			scale.x = scale.y
			combo = 1
			$AnimationPlayer.play("RUN2")

func get_direction_after_attacking(): #see attack animations in AnimationPlayer
	if Input.is_action_pressed("ui_right"): #if player finishes attack and wants to change direction
		scale.x = -scale.y
	elif Input.is_action_pressed("ui_left"): #if player finishes attack and wants to change direction
		scale.x = scale.y


func get_jump_input():
	if Input.is_action_just_pressed("jump") && !attacking: #if you press jump and are not attacking
		if is_on_floor() || $AnimationPlayer.current_animation == "CLIMBING" || double_jump == true:
			velocity.y = jumpforce
			double_jump = false
			$JumpSound.play()
			if !is_on_floor() && $AnimationPlayer.current_animation != "CLIMBING":
				var double_jump_particle_instance = double_jump_particle.instance()
				double_jump_particle_instance.global_position = Vector2(global_position.x, global_position.y)
				get_parent().add_child(double_jump_particle_instance)
	if Input.is_action_just_released("jump") && velocity.y < -100:
		velocity.y = -100

	if velocity.y < 0 && !attacking: #when you start jumping
		$AnimationPlayer.play("JUMP_START")
	if velocity.y > gravity && !is_on_floor() && !attacking: #when you are falling
		$AnimationPlayer.play("FALLING")
	if is_on_floor() && $AnimationPlayer.current_animation == "FALLING" && !attacking: #when you land from jump
		$AnimationPlayer.play("LANDING")


func get_attack_input():
	if Input.is_action_pressed("attack1") && !attacking && combo == 1:  #if you press attacking button and are not currently attacking
		attacking = true
		$AnimationPlayer.play("SLASH")
	if Input.is_action_pressed("attack1") && !attacking && combo == 2:  #if you press attacking button and are in a combo
		attacking = true
		$AnimationPlayer.play("SLASH_2")
	if Input.is_action_pressed("attack1") && !attacking && combo == 3:  #if you press attacking button and are in a combo
		attacking = true
		$AnimationPlayer.play("CRUSHER")
	
	if Input.is_action_pressed("attack2") && !attacking && Hud.get_node("ManaBar").value >= HudSkill.current_skill1_mana_cost && HudSkill.current_skill1 != "" && !$AnimationPlayer.current_animation == "CLIMBING" && !$AnimationPlayer.current_animation == HudSkill.current_skill1:
		Hud.get_node("ManaBar").set_bar_value(Hud.get_node("ManaBar").value - HudSkill.current_skill1_mana_cost)
		PlayerBasicData.current_mana -= HudSkill.current_skill1_mana_cost
		attacking = true
		combo = 1
		$AnimationPlayer.play(HudSkill.current_skill1)
	if Input.is_action_pressed("attack3") && !attacking && Hud.get_node("ManaBar").value >= HudSkill.current_skill2_mana_cost && HudSkill.current_skill2 != "" && !$AnimationPlayer.current_animation == "CLIMBING" && !$AnimationPlayer.current_animation == HudSkill.current_skill2:
		Hud.get_node("ManaBar").set_bar_value(Hud.get_node("ManaBar").value - HudSkill.current_skill2_mana_cost)
		PlayerBasicData.current_mana -= HudSkill.current_skill2_mana_cost
		attacking = true
		combo = 1
		$AnimationPlayer.play(HudSkill.current_skill2)
	if Input.is_action_pressed("attack4") && !attacking && Hud.get_node("ManaBar").value >= HudSkill.current_skill3_mana_cost && HudSkill.current_skill3 != "" && !$AnimationPlayer.current_animation == "CLIMBING" && !$AnimationPlayer.current_animation == HudSkill.current_skill3:
		Hud.get_node("ManaBar").set_bar_value(Hud.get_node("ManaBar").value - HudSkill.current_skill3_mana_cost)
		PlayerBasicData.current_mana -= HudSkill.current_skill3_mana_cost
		attacking = true
		combo = 1
		$AnimationPlayer.play(HudSkill.current_skill3)

func wall_climb():
	if !is_on_floor() && $WallClimbDetector.get_overlapping_bodies() && !$AnimationPlayer.current_animation == "JUMP_START" && !$AnimationPlayer.current_animation == "DASH" && game_data.can_wall_climb == true:
		$AnimationPlayer.play("CLIMBING")
		can_dash = true
		if Input.is_action_pressed("ui_down"):
			var wall_slide_particle_instance = wall_slide_particle.instance()
			wall_slide_particle_instance.emitting = true
			wall_slide_particle_instance.global_position = Vector2(global_position.x, global_position.y)
			get_parent().add_child(wall_slide_particle_instance)
			velocity.y = speed
		else:
			velocity.y = -gravity

func idle():
	if !$AnimationPlayer.is_playing(): #if no other animation is playing
		$AnimationPlayer.play("IDLE")
		attacking = false
	elif velocity.x <= 1 && velocity.x >= -1 && $AnimationPlayer.current_animation == "RUN2": #if you dont move
		$AnimationPlayer.play("IDLE")
		attacking = false


func get_dash_input():
	if Input.is_action_just_pressed("dash") && $DashCooldown.time_left == 0.0 && can_dash:
		$AnimationPlayer.play("DASH")
		$DashCooldown.start()
		attacking = true
		combo = 1
	if $AnimationPlayer.current_animation == "DASH":
		velocity.x += dash_speed * -scale.y
		velocity.y = -gravity


func die():
	if PlayerBasicData.current_lives <= 0:
		$AnimationPlayer.play("DEATH")
		set_physics_process(false)


func _process(delta):
	camera_screen_shake()
	check_camera_vertical_movement()
	knock_back()
	idle()

func _physics_process(delta):
	if is_on_floor() && SaveFile.game_data.can_double_jump == true:
		double_jump = true
	velocity.y = velocity.y + gravity
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x,0,0.5)
	get_attack_input()
	get_movement_input()
	get_jump_input()
	get_dash_input()
	wall_climb()


func camera_screen_shake():
	$MainCamera.set_offset(Vector2(rand_range(-2, 2) * shake_power, rand_range(-2, 2) * shake_power))

func _on_CameraShakeTimer_timeout():
	$MainCamera.set_offset(Vector2(0, 0))
	shake_power = 0.0 #after timeout set screen power to 0 -> camera is no longer shaking


func _on_HitBox_area_entered(area): #getting hit sets knock_back
	if area.is_in_group("attack"): #if its an attack an player can be damaged
		enemy_direction = 1 if area.get_parent().global_position.x < global_position.x else 0 #get direction of the attack
		shake_power = area.attack_shake_power #shake the screen
		$CameraShakeTimer.start()
		enemy_attack_knock_back_power = area.get_parent().attack_knock_back_power #knockback the player
		$KnockBackTimer.start()

func knock_back():
	if $KnockBackTimer.time_left != 0:
		velocity.x += enemy_attack_knock_back_power if enemy_direction > 0 else -enemy_attack_knock_back_power #knockback player
	else:
		enemy_attack_knock_back_power = 0


func check_camera_vertical_movement(): #after player lends camera will smoothly follow
	was_grounded = is_grounded
	is_grounded = is_on_floor()
	
	if was_grounded == null || is_grounded != was_grounded:
		emit_signal("grounded_updated", is_grounded)


func death_anim():
	Engine.time_scale = 0.25
	shake_power = 3.0
	$DeathScreen.visible = true
	z_index = 4096
	Hud.visible = false
	HudSkill.visible = false

func load_after_death():
	velocity.y = 0
	velocity.x = 0
	get_tree().change_scene(game_data.current_scene)
	Hud.get_node("Lives").set_physics_process(true)
	Hud.get_node("Healing").set_physics_process(true)
	Hud.visible = true
	HudSkill.visible = true
	print(game_data)
	PlayerBasicData._ready()
	global_position.x = game_data.positionx
	global_position.y = game_data.positiony
	Hud.get_node("Lives").update_lives()
	Hud.get_node("Healing").update_healing()
	Hud.get_node("ManaBar").set_to_max()
	get_tree().call_group("enemy", "respawn")

func engine_time_scale():
	Engine.time_scale = 1.0

func spawn_run_particle():
	var run_particle_instance = run_particle.instance()
	run_particle_instance.global_position = Vector2(global_position.x, global_position.y+12)
	run_particle_instance.emitting = true
	get_parent().add_child(run_particle_instance)

func spawn_fireball_skill():
	var fireball_instance = fireball.instance()
	fireball_instance.global_position = global_position
	get_parent().add_child(fireball_instance)

func disable_all_attack_hitboxes():
	$SlashHit.monitoring = false
	$CrusherHit.monitoring = false
	$StoneGolemSkillHit.monitoring = false
