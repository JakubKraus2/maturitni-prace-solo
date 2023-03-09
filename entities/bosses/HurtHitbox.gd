extends StaticBody2D


onready var timer = get_parent().timer
onready var hurt_timer = get_parent().hurt_timer
onready var hp = get_parent().hp
onready var health_bar = get_parent().health_bar

func _ready() -> void:
	timer = get_parent().timer
	hurt_timer = get_parent().hurt_timer
	hp = get_parent().hp
	health_bar = get_parent().health_bar
