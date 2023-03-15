extends CollisionShape2D


func _physics_process(delta: float) -> void:
	global_position = Vector2(owner.get_parent().get_node("HeartHoarderBoss2").global_position.x, owner.get_parent().get_node("HeartHoarderBoss2").global_position.y + 50)
