extends CollisionShape2D


func _process(delta):
	global_position = Vector2(owner.get_parent().get_node("HeartHoarderBoss2").global_position.x, owner.get_parent().get_node("HeartHoarderBoss2").global_position.y + 33)
