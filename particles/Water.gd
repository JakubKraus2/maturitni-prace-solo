tool
extends Sprite

func _process(delta: float) -> void:
	zoom_changed()

func _on_Water_item_rect_changed() -> void:
	material.set_shader_param("scale", scale)

func zoom_changed():
	material.set_shader_param("y_zoom", get_viewport_transform().get_scale().y)

func _on_waterDamage_body_entered(body):
	SwordsMaster.die()
	SwordsMaster.load_after_death()
