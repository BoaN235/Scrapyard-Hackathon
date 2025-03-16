extends Node2D

var HP = Stats.stats["HP"]
var strength = Stats.stats["strength"]
var Nvp = Stats.stats["Nvp"]
var card_images = Stats.card_images
var card_values = Stats.card_values
var hand = []
var attacking = false
var lastcard 
@onready var damgetag = $Cards/Damage



class Card:
	var sprite
	var button
	var node
	var panel
	var original_pos = Vector2()
	var offset = Vector2()
	var main_node
	var inuse
	var moving
	var number

	func _init(main_node, img):
		self.main_node = main_node
		sprite = Sprite2D.new()
		button = Button.new()
		node = Control.new()
		panel = Panel.new()
		var texture = load(img)
		sprite.texture = texture
		panel.visible = false
		node.mouse_filter = Control.MOUSE_FILTER_IGNORE
		number = main_node.card_values[img]  # Assign the card value

	func _on_button_down():
		panel.visible = true
		sprite.z_index = 1
		panel.z_index = 1
		original_pos = sprite.position
		inuse = true
		offset = node.position - node.get_viewport().get_mouse_position()

	func _on_button_up():
		panel.visible = false
		sprite.z_index = -1
		panel.z_index = -1
		sprite.position = original_pos
		inuse = false
		if main_node.attacking:
			play()
			main_node.discard_card(self)

	func play():
		pass



	func update_position():
		if panel.visible:
			var mouse_pos = node.get_viewport().get_mouse_position()
			if mouse_pos:
				sprite.position = mouse_pos 

func _ready() -> void:
	for i in range(5):
		draw_card()

func draw_card():
	if hand.size() >= 6:
		discard_card(hand[5])  # Discard the first card if the hand size exceeds 6
	var random_index = randi() % card_images.size()
	var img = card_images[random_index]
	var card = Card.new(self, img)
	card.sprite.position = Vector2(hand.size() * 125 + 350, 460)  # Adjust position based on hand size
	card.button.position = Vector2(hand.size() * 125 + 250, 380)  # Adjust position based on hand size
	card.sprite.scale = card.sprite.texture.get_size() / 26
	card.button.scale = card.sprite.texture.get_size() / 5
	card.button.connect("button_down", Callable(card, "_on_button_down"))
	card.button.connect("button_up", Callable(card, "_on_button_up"))
	card.button.keep_pressed_outside = true
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
		if card.inuse:
			if attacking: 
				if card.moving:
					pass

func _on_panel_2_mouse_entered() -> void:
	attacking = true
	for card in hand:
		if !card.node.position == card.original_pos:
			card.moving = true

func _on_panel_2_mouse_exited() -> void:
	attacking = false
	for card in hand:
		card.moving = false

func end_turn():
	draw_card()

func get_random_card() -> Card:
	if hand.size() > 0:
		var random_index = randi() % hand.size()
		return hand[random_index]
	return null


func _on_end_turn_button_pressed() -> void:
	end_turn()
