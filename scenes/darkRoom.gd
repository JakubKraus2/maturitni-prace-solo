extends Node2D

var _mouse_position

func _ready():
	pass # Replace with function body.

func _on_light_popup_body_entered(body):
	_mouse_position = get_global_mouse_position()
	$light.popup(Rect2(_mouse_position.x, _mouse_position.y, $light.rect_size.x, $light.rect_size.y))

func _on_skill_popup_body_entered(body):
	_mouse_position = get_global_mouse_position()
	$skill.popup(Rect2(_mouse_position.x, _mouse_position.y, $skill.rect_size.x, $skill.rect_size.y))

func _on_movement_popup2_body_entered(body):
	_mouse_position = get_global_mouse_position()
	$movement.popup(Rect2(_mouse_position.x, _mouse_position.y, $movement.rect_size.x, $movement.rect_size.y))

func _on_climb_popup2_body_entered(body):
	_mouse_position = get_global_mouse_position()
	$climb.popup(Rect2(_mouse_position.x, _mouse_position.y, $climb.rect_size.x, $climb.rect_size.y))
