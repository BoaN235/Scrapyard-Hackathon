extends Control
var HP = Stats.stats["HP"]
var MHP = Stats.stats["MHP"]
var Nvp = Stats.stats["Nvp"]
var Lvl = Stats.stats["Lvl"]


@onready var money = $Control/Chips/Chips
@onready var health = $HP
@onready var level = $Control/Label

func _process(delta: float) -> void:
	money.text = str(Nvp)
	health.text =  str(HP) + "/" + str(MHP)
	level.text = "level: " + str(Lvl)
