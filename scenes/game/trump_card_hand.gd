class_name TrumpCardHand
extends HBoxContainer

@export var player_stats: Stats

@onready var trumpcard_ui: PackedScene = preload("res://scenes/trumpcard_ui/trumpcard_ui.tscn")

var cards_played_this_turn: int = 0


func _ready() -> void:
	Events.player_card_played.connect(_on_trump_card_played)
	#Events.player_hand_drawn.connect(add_card)
	


func add_card(card: TrumpCard) -> void:
	var new_card_ui: TrumpCardUI = trumpcard_ui.instantiate()
	add_child(new_card_ui)
	new_card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)
	new_card_ui.card = card
	new_card_ui.parent = self


func enable_hand() -> void:
	for card: TrumpCardUI in get_children():
		if card.playable:
			card.disabled = false


func disable_hand() -> void:
	for card: TrumpCardUI in get_children():
		card.disabled = true


func _on_trump_card_played(_card: TrumpCard) -> void:
	cards_played_this_turn += 1


func _on_card_ui_reparent_requested(child: TrumpCardUI) -> void:
	child.reparent(self)
	var new_index: int = clampi(child.original_index - cards_played_this_turn, 0, get_child_count())
	move_child.call_deferred(child, new_index)
