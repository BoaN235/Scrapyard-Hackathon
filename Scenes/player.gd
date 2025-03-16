extends Node2D

var HP = Stats.stats["HP"]
var strength = Stats.stats["strength"]
var Nvp = Stats.stats["Nvp"]
var hand = []
var attacking = false
var lastcard 
@onready var damgetag = $Cards/Damage

var card_images = [
	"res://Cards/Images/Norm 2 Spades.png",
	"res://Cards/Images/N5S.png",
	"res://Cards/Images/lockpos3.png",
	"res://Cards/Images/N9S.png",
	"res://Cards/Images/5s.png",
	"res://Cards/Images/n10h.png",
	"res://Cards/Images/n5h.png",
	"res://Cards/Images/n9h.png",
	"res://Cards/Images/3d.png",
	"res://Cards/Images/N6S.png",
	"res://Cards/Images/n4h.png",
	"res://Cards/Images/n4d.png",
	"res://Cards/Images/nqs.png",
	"res://Cards/Images/nkc.png",
	"res://Cards/Images/N8S.png",
	"res://Cards/Images/n3c.png",
	"res://Cards/Images/n10s.png",
	"res://Cards/Images/nAs.png",
	"res://Cards/Images/9h.png",
	"res://Cards/Images/n10d.png",
	"res://Cards/Images/ah.png",
	"res://Cards/Images/3h.png",
	"res://Cards/Images/norm 3 spades.png",
	"res://Cards/Images/4s.png",
	"res://Cards/Images/jd.png",
	"res://Cards/Images/4h.png",
	"res://Cards/Images/n3d.png",
	"res://Cards/Images/n7h.png",
	"res://Cards/Images/n2d.png",
	"res://Cards/Images/n8h.png",
	"res://Cards/Images/n5c.png",
	"res://Cards/Images/n10c.png",
	"res://Cards/Images/2nh.png",
	"res://Cards/Images/n9d.png",
	"res://Cards/Images/jc.png",
	"res://Cards/Images/6s.png",
	"res://Cards/Images/ncb.png",
	"res://Cards/Images/3s.png",
	"res://Cards/Images/nkd.png",
	"res://Cards/Images/kh.png",
	"res://Cards/Images/n4c.png",
	"res://Cards/Images/9s.png",
	"res://Cards/Images/nkh.png",
	"res://Cards/Images/n2c.png",
	"res://Cards/Images/n7s.png",
	"res://Cards/Images/n7d.png",
	"res://Cards/Images/N4S.png",
	"res://Cards/Images/njH.png",
	"res://Cards/Images/6d.png",
	"res://Cards/Images/10c.png",
	"res://Cards/Images/2d.png",
	"res://Cards/Images/6h.png",
	"res://Cards/Images/8c.png",
	"res://Cards/Images/7d.png",
	"res://Cards/Images/8h.png",
	"res://Cards/Images/2c.png",
	"res://Cards/Images/js.png",
	"res://Cards/Images/7c.png",
	"res://Cards/Images/njc.png",
	"res://Cards/Images/2s.png",
	"res://Cards/Images/6c.png",
	"res://Cards/Images/njD.png",
	"res://Cards/Images/7s.png",
	"res://Cards/Images/8s.png",
	"res://Cards/Images/nah.png",
	"res://Cards/Images/nac.png",
	"res://Cards/Images/nks.png",
	"res://Cards/Images/3c.png",
	"res://Cards/Images/nqc.png",
	"res://Cards/Images/n5d.png",
	"res://Cards/Images/ad.png",
	"res://Cards/Images/n9c.png",
	"res://Cards/Images/10d.png",
	"res://Cards/Images/as.png",
	"res://Cards/Images/5d.png",
	"res://Cards/Images/kc.png"
]

var card_values = {
	"res://Cards/Images/Norm 2 Spades.png": 2,
	"res://Cards/Images/N5S.png": 5,
	"res://Cards/Images/lockpos3.png": 3,
	"res://Cards/Images/N9S.png": 9,
	"res://Cards/Images/5s.png": 5,
	"res://Cards/Images/n10h.png": 10,
	"res://Cards/Images/n5h.png": 5,
	"res://Cards/Images/n9h.png": 9,
	"res://Cards/Images/3d.png": 3,
	"res://Cards/Images/N6S.png": 6,
	"res://Cards/Images/n4h.png": 4,
	"res://Cards/Images/n4d.png": 4,
	"res://Cards/Images/nqs.png": 12,
	"res://Cards/Images/nkc.png": 13,
	"res://Cards/Images/N8S.png": 8,
	"res://Cards/Images/n3c.png": 3,
	"res://Cards/Images/n10s.png": 10,
	"res://Cards/Images/nAs.png": 14,
	"res://Cards/Images/9h.png": 9,
	"res://Cards/Images/n10d.png": 10,
	"res://Cards/Images/ah.png": 14,
	"res://Cards/Images/3h.png": 3,
	"res://Cards/Images/norm 3 spades.png": 3,
	"res://Cards/Images/4s.png": 4,
	"res://Cards/Images/jd.png": 11,
	"res://Cards/Images/4h.png": 4,
	"res://Cards/Images/n3d.png": 3,
	"res://Cards/Images/n7h.png": 7,
	"res://Cards/Images/n2d.png": 2,
	"res://Cards/Images/n8h.png": 8,
	"res://Cards/Images/n5c.png": 5,
	"res://Cards/Images/n10c.png": 10,
	"res://Cards/Images/2nh.png": 2,
	"res://Cards/Images/n9d.png": 9,
	"res://Cards/Images/jc.png": 11,
	"res://Cards/Images/6s.png": 6,
	"res://Cards/Images/ncb.png": 0,
	"res://Cards/Images/3s.png": 3,
	"res://Cards/Images/nkd.png": 13,
	"res://Cards/Images/kh.png": 13,
	"res://Cards/Images/n4c.png": 4,
	"res://Cards/Images/9s.png": 9,
	"res://Cards/Images/nkh.png": 13,
	"res://Cards/Images/n2c.png": 2,
	"res://Cards/Images/n7s.png": 7,
	"res://Cards/Images/n7d.png": 7,
	"res://Cards/Images/N4S.png": 4,
	"res://Cards/Images/njH.png": 11,
	"res://Cards/Images/6d.png": 6,
	"res://Cards/Images/10c.png": 10,
	"res://Cards/Images/2d.png": 2,
	"res://Cards/Images/6h.png": 6,
	"res://Cards/Images/8c.png": 8,
	"res://Cards/Images/7d.png": 7,
	"res://Cards/Images/8h.png": 8,
	"res://Cards/Images/2c.png": 2,
	"res://Cards/Images/js.png": 11,
	"res://Cards/Images/7c.png": 7,
	"res://Cards/Images/njc.png": 11,
	"res://Cards/Images/2s.png": 2,
	"res://Cards/Images/6c.png": 6,
	"res://Cards/Images/njD.png": 11,
	"res://Cards/Images/7s.png": 7,
	"res://Cards/Images/8s.png": 8,
	"res://Cards/Images/nah.png": 14,
	"res://Cards/Images/nac.png": 14,
	"res://Cards/Images/nks.png": 13,
	"res://Cards/Images/3c.png": 3,
	"res://Cards/Images/nqc.png": 12,
	"res://Cards/Images/n5d.png": 5,
	"res://Cards/Images/ad.png": 14,
	"res://Cards/Images/n9c.png": 9,
	"res://Cards/Images/10d.png": 10,
	"res://Cards/Images/as.png": 14,
	"res://Cards/Images/5d.png": 5,
	"res://Cards/Images/kc.png": 13
}

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
		original_pos = node.position
		inuse = true
		offset = node.position - node.get_viewport().get_mouse_position()

	func _on_button_up():
		panel.visible = false
		sprite.z_index = -1
		panel.z_index = -1
		node.position = original_pos
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
					discard_card(card)

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
