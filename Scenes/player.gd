extends Node2D

var HP = Stats.stats["HP"]
var strength = Stats.stats["strength"]
var Nvp = Stats.stats["Nvp"]
var hand

func _ready() -> void:
	for i in range(5):
		draw()

func draw():
	pass

func discard():
	pass

func start():
	pass
