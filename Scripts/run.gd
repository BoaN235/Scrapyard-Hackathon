extends Node



@onready var map = get_node("Maps")

func _ready():
	var rng = RandomNumberGenerator.new()
	for i in range(6):
		var my_random_number = rng.randf_range(200.0, 900.0)
		var my_random_number2 = rng.randf_range(100.0, 500.0)
		
		# Create a new Sprite2D node
		var new_sprite = Sprite2D.new()

		# Set the sprite's texture (optional)
		new_sprite.texture = preload("res://Assets/QuestionMark.png")

		new_sprite.position = Vector2(my_random_number, my_random_number2)

		# Add the sprite as a child of the current node
		add_child(new_sprite)
