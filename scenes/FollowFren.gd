extends Node2D

var num = 0
var follow = true
var p = 0
var _mouse_position

func _process(delta):
	if (follow == true):
		num += delta
		$Path2D2/PathFollow2D.offset = num * 80
	else:
		p

func _on_player_body_entered(body):
	follow = false
	p = $Path2D2/PathFollow2D.get_position_in_parent()

func _on_player_body_exited(body):
	follow = true

func _on_popup_body_entered(body):
	_mouse_position = get_global_mouse_position()
	$fren.popup(Rect2(_mouse_position.x, _mouse_position.y, $fren.rect_size.x, $fren.rect_size.y))
