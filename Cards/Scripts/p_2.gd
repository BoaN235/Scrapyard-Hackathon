extends Node2D

@onready var panel = get_node("Panel")
var offset = Vector2()

func _on_button_button_down() -> void:
	panel.visible = true
	offset = position - get_global_mouse_position()

func _on_button_button_up() -> void:
	panel.visible = false

func _process(delta: float) -> void:
	if panel.visible == true:
		position = get_global_mouse_position() + offset
