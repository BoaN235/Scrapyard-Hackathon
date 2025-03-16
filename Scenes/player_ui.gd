extends Control
var HP = Stats.stats["HP"]
var strength = Stats.stats["strength"]
var Nvp = Stats.stats["Nvp"]

@onready var money = $Control/Chips/Chips

func _process(delta: float) -> void:
	money.text = str(Nvp)
