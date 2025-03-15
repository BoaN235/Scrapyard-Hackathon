extends Node

@onready var map = get_node("Maps")

class Room:
	var sprite
	var connections = []
	var position = Vector2.ZERO
	var size = Vector2(100, 100)  # Default room size

	func set_position(new_position: Vector2):
		position = new_position
		sprite.position = position

	func set_size(new_size: Vector2):
		size = new_size
		sprite.scale = new_size / sprite.texture.get_size()

func _ready():
	var rng = RandomNumberGenerator.new()
	var rooms = []
	var line = Line2D.new()
	line.default_color = Color(0.2, 0.2, 0.2, 1)
	line.width = 4
	add_child(line)
	
	var room_count = 26
	var min_distance = 100   # Minimum distance between rooms
	
	# Generate rooms with position and size
	for i in range(room_count):
		var room = Room.new()
		var xlocation = rng.randf_range(200.0, 900.0)
		var ylocation = rng.randf_range(100.0, 500.0)
	
		# Check for overlaps with existing rooms
		var overlap = false
		for existing_room in rooms:
			var distance = existing_room.position.distance_to(Vector2(xlocation, ylocation))
			if distance < min_distance:
				overlap = true
				break
	
		if overlap:
			i -= 1  # Retry this iteration if overlap occurs
			continue
	
		# Create sprite for the room
		var new_sprite = Sprite2D.new()
		new_sprite.texture = preload("res://Assets/QuestionMark.png")
		new_sprite.position = Vector2(xlocation, ylocation)
		add_child(new_sprite)
	
		# Set random size for the room
		room.sprite = new_sprite
		room.set_position(Vector2(xlocation, ylocation))
	
		rooms.append(room)
	
	# Connect rooms in a more structured way (using a simple graph-based approach)
	for room in rooms:
		var num_connections = rng.randi_range(1, 3)  # Each room can have 1-3 connections
		while len(room.connections) < num_connections:
			var other_room = rooms[rng.randi_range(0, rooms.size() - 1)]
			if other_room != room and other_room not in room.connections:
				room.connections.append(other_room)
				other_room.connections.append(room)
				line.add_point(room.position)
				line.add_point(other_room.position)
	
	# Remove rooms with no connections (if any)
	for room in rooms:
		if len(room.connections) == 0:
			remove_child(room.sprite)
			room.sprite.queue_free()
