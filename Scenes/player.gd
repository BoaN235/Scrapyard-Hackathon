extends Node2D

var HP = Stats.stats["HP"]
var strength = Stats.stats["strength"]
var Nvp = Stats.stats["Nvp"]
var hand = []
var attacking = false

class Card:
	var sprite
	var button
	var node
	var panel
	var original_pos = Vector2()
	var offset = Vector2()
	var main_node

	func _init(main_node):
		self.main_node = main_node
		sprite = Sprite2D.new()
		button = Button.new()
		node = Node2D.new()
		panel = Panel.new()
		var img = "res://Cards/Images/Norm 2 Spades.png"
		var texture = load(img)
		sprite.texture = texture
		panel.visible = false

	func _on_button_down():
		panel.visible = true
		sprite.z_index = 1
		panel.z_index = 1
		original_pos = node.position
		offset = node.position - node.get_viewport().get_mouse_position()

	func _on_button_up():
		panel.visible = false
		sprite.z_index = -1
		panel.z_index = -1
		node.position = original_pos
		if main_node.attacking:
			print("hi")
			main_node.discard_card(self)

	func update_position():
		if panel.visible:
			var mouse_pos = node.get_viewport().get_mouse_position()
			if mouse_pos:
				node.position = mouse_pos + offset

func _ready() -> void:
	for i in range(5):
		draw_card()

func draw_card():
	var card = Card.new(self)
	card.sprite.position = Vector2(hand.size() * 125 + 350, 460)  # Adjust position based on hand size
	card.button.position = Vector2(hand.size() * 125 + 250, 380)  # Adjust position based on hand size
	card.sprite.scale = card.sprite.texture.get_size() / 26
	card.button.scale = card.sprite.texture.get_size() / 5
	card.button.connect("button_down", Callable(card, "_on_button_down"))
	card.button.connect("button_up", Callable(card, "_on_button_up"))
	card.button.modulate = Color(1, 1, 1, 0)  # Make the button invisible
	card.node.add_child(card.sprite)
	card.node.add_child(card.button)
	card.node.add_child(card.panel)
	add_child(card.node)  # Add the card node to the scene tree
	hand.append(card)

func discard_card(card):
	if card in hand:
		hand.erase(card)
		remove_child(card.node)
		card.node.queue_free()
		update_hand_positions()

func update_hand_positions():
	for i in range(hand.size()):
		hand[i].sprite.position = Vector2(i * 100, 0)  # Adjust position based on new hand size

func start():
	# Initialize or reset the hand
	for card in hand:
		remove_child(card.node)
		card.node.queue_free()
	hand.clear()
	for i in range(5):
		draw_card()

func _process(delta: float) -> void:
	for card in hand:
		card.update_position()

func _on_panel_2_mouse_entered() -> void:
	print("b")
	attacking = true

func _on_panel_2_mouse_exited() -> void:
	attacking = false
	print("d")
