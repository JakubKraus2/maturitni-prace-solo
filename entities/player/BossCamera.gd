extends Camera2D


func _ready():
	limit_right = get_viewport_rect().size.x
	limit_left = get_viewport_transform().origin.x


func _on_SwordsMaster_grounded_updated(is_grounded):
	drag_margin_v_enabled = !is_grounded
