extends KinematicBody2D

var attack_knock_back_power = 0
var speed = 5
var velocity = Vector2(0, 0)

func _ready() -> void:
	$AnimationPlayer.play("DEFAULT")

func _process(delta: float) -> void:
	velocity.y += speed
	velocity.y = clamp(velocity.y, 150, 300) #clamp(value, min_value, max_value)
	move_and_slide(velocity, Vector2.UP)


func _on_HitBox_area_entered(area: Area2D) -> void:
	if area.get_parent().invincibility_timer.time_left == 0: #cant be damaged twice in certain period of time
		area.get_parent().attacking = true #player cant move
		area.get_parent().animation_player.play("HURT") #play hurt anim
		area.get_parent().invincibility_timer.start() #start the invincibility timer
		PlayerBasicData.current_lives -= 1 #damage
		area.get_parent().die() #check if player is dead
		set_process(false)
		$AnimationPlayer.play("Explosion")


func _on_ExplosionTerrainHitbox_body_entered(body: Node) -> void:
	set_process(false)
	$HitBox/CollisionShape2D.set_deferred("disabled", true)
	$AnimationPlayer.play("Explosion")
