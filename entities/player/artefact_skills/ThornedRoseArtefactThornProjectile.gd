extends KinematicBody2D


var speed = 500
var velocity = Vector2.ZERO


func _physics_process(delta: float) -> void:
	velocity = Vector2(-speed, 0).rotated(rotation)
	velocity = move_and_slide(velocity)
