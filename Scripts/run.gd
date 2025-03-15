extends Node


@onready var map = get_node("Maps")

func _ready():
	var maps = map.get_children()
	for map in maps:
		map.text = "?"
