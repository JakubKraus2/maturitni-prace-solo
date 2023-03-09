extends Camera2D


onready var main_camera = get_node("root/BossArena/SwordsMaster/MainCamera")


func _ready() -> void:
	current = true
	print(main_camera.position)
	
