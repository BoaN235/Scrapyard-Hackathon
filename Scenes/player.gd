extends Node2D

var HP = Stats.stats["HP"]
var strength = Stats.stats["strength"]
var Nvp = Stats.stats["Nvp"]
var hand = []

class Card:
	var sprite
	var button

	func _init():
		sprite = Sprite2D.new()
		button = Button.new()
		var img = "res://Cards/Images/Norm 2 Spades.png"
		var texture = load(img)
		sprite.texture = texture

	func _on_button_down():
		print("Button down")

	func _on_button_up():
		print("Button up")

func _ready() -> void:
	for i in range(5):
		draw_card()

func draw_card():
	var card = Card.new()
	card.sprite.position = Vector2(hand.size() * 125 + 100, 500)  # Adjust position based on hand size
	card.button.position = Vector2(hand.size() * 125 + 100, 500)  # Adjust position based on hand size
	card.sprite.scale = card.sprite.texture.get_size() / 26
	card.button.scale = card.sprite.texture.get_size() / 5
	card.button.connect("button_down", Callable(card, "_on_button_down"))
	card.button.connect("button_up", Callable(card, "_on_button_up"))
	add_child(card.sprite)
	add_child(card.button)
	hand.append(card)

func discard_card(card):
	if card in hand:
		hand.erase(card)
		remove_child(card.sprite)
		card.sprite.queue_free()
		update_hand_positions()

func update_hand_positions():
	for i in range(hand.size()):
		hand[i].sprite.position = Vector2(i * 100, 0)  # Adjust position based on new hand size

func start():
	# Initialize or reset the hand
	for card in hand:
		remove_child(card.sprite)
		card.sprite.queue_free()
	hand.clear()
	for i in range(5):
		draw_card()

func _on_button_up(button: Button):
	print("e")

func _on_button_down(button: Button):
	print("b")
