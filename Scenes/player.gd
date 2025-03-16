extends Node2D

var HP = Stats.stats["HP"]
var strength = Stats.stats["strength"]
var Nvp = Stats.stats["Nvp"]
var OPHP = Stats.dealer["HP"]
var OPMHP = Stats.dealer["MHP"]
var card_images = Stats.card_images
var card_values = Stats.card_values
var hand = []
var draw_pile = []
var discard_pile = []
var attacking = false
var lastcard 
@onready var damgetag = $Cards/Damage
@onready var librarytext = $"../PlayerUI/Library/Label"
@onready var discardtext = $"../PlayerUI/Discard/Label"
@onready var enemyhealth = $"../PlayerUI/Control/HPOP"

class Card:
	var sprite
	var button
	var node
	var panel
	var original_pos = Vector2()
	var offset = Vector2()
	var main_node
	var inuse = false
	var moving = false
	var number

	@warning_ignore("shadowed_variable")
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
		# Deal damage to the dealer
		var damage = number
		main_node.deal_damage_to_dealer(damage)
		main_node.end_turn()

	func update_position():
		if panel.visible:
			var mouse_pos = node.get_viewport().get_mouse_position()
			if mouse_pos:
				sprite.position = mouse_pos
				button.position = mouse_pos

func _ready() -> void:
	# Initialize the draw pile with the deck from Stats
	draw_pile = Stats.stats["deck"].duplicate()
	print(draw_pile)
	shuffle_draw_pile()
	for i in range(5):
		draw_card()

func shuffle_draw_pile():
	draw_pile.shuffle()

func draw_card():
	if draw_pile.size() == 0:
		draw_pile = discard_pile.duplicate()
		discard_pile.clear()
		shuffle_draw_pile()
	if hand.size() >= 6:
		discard_card(hand[0])  # Discard the first card if the hand size exceeds 
	if draw_pile.size() > 0:
		var img_index = draw_pile.pop_back()
		var img = card_images[img_index]  # Get the image path using the index
		var card = Card.new(self, img)
		var empty_slot = -1
		for i in range(6):
			if i >= hand.size() or hand[i] == null:
				empty_slot = i
				break
		if empty_slot != -1:
			card.sprite.position = Vector2(empty_slot * 125 + 350, 460)  # Adjust position based on slot
			card.button.position = Vector2(empty_slot * 125 + 250, 380)  # Adjust position based on slot
			card.sprite.scale = card.sprite.texture.get_size() / 26
			card.button.scale = card.sprite.texture.get_size() / 5
			card.button.connect("button_down", Callable(card, "_on_button_down"))
			card.button.connect("button_up", Callable(card, "_on_button_up"))
			card.button.keep_pressed_outside = true
			card.button.modulate = Color(1, 1, 1, 0)  # Make the button invisible
			card.node.add_child(card.sprite)
			card.node.add_child(card.button)
			card.node.add_child(card.panel)
			self.add_child(card.node)  # Add the card node to the scene tree
			if empty_slot < hand.size():
				hand[empty_slot] = card
			else:
				hand.append(card)

func discard_card(card):
	if card in hand:
		hand.erase(card)
		self.remove_child(card.node)
		card.node.queue_free()
		discard_pile.append(card.number)  # Add the card to the discard pile
		print(card.number)

func update_hand_positions():
	for i in range(hand.size()):
		if hand[i] != null:
			hand[i].sprite.position = Vector2(i * 100, 0)  # Adjust position based on slot

func start():
	# Initialize or reset the hand
	for card in hand:
		self.remove_child(card.node)
		card.node.queue_free()
	hand.clear()
	for i in range(5):
		draw_card()

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	for card in hand:
		card.update_position()
		if card.inuse:
			if attacking: 
				if card.moving:
					pass
	if discardtext and librarytext and enemyhealth:
		discardtext.text = str(len(discard_pile))
		librarytext.text = str(len(draw_pile))
		enemyhealth.text = str(Stats.dealer["HP"]) + "/" + str(Stats.dealer["MHP"])

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

func deal_damage_to_dealer(damage):
	Stats.dealer["HP"] = Stats.dealer["HP"] - damage
	print(damage, " ", Stats.dealer["HP"])
	if Stats.dealer["HP"] <= 0:
		win()
	if enemyhealth:
		enemyhealth.text = str(Stats.dealer["HP"]) + "/" + str(Stats.dealer["MHP"])

func win():
	Stats.dealer["HP"] = Stats.dealer["MHP"]
	Stats.stats["HP"] = Stats.stats["MHP"]
	get_tree().change_scene_to_file("res://Scenes/run.tscn")
