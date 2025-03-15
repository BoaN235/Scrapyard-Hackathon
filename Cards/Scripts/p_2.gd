extends Node2D

@onready var panel = get_node("Panel")
@onready var image = get_node("Image").get_child(0)
var offset = Vector2()

func _on_button_button_down() -> void:
	panel.visible = true
	image.z_index =+ 1;
	panel.z_index =+ 1;
	offset = position - get_global_mouse_position()

func _on_button_button_up() -> void:
	panel.visible = false
	image.z_index =- 1;
	panel.z_index =- 1;

func _process(delta: float) -> void:
	if panel.visible == true:
		position = get_global_mouse_position() + offset
