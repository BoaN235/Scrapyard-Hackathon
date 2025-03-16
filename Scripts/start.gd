extends Node2D



func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://Scenes/home.tscn")

func _on_button_3_pressed():
	get_tree().quit()
