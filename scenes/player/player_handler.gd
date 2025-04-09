class_name PlayerHandler
extends Node

const HAND_DRAW_INTERVAL: float = .25

@export var trump_card_hand: TrumpCardHand
@export var trump_card_pile: TrumpCardPile

var character: Stats


func start_battle(player_stats: Stats) -> void:
	character = player_stats
	character.trump_card_pile = trump_card_pile.duplicate(true)
	character.trump_card_pile.shuffle()
	start_turn()


func start_turn() -> void:
	character.block = 0
	draw_cards(character.cards_per_turn)


func end_turn() -> void:
	trump_card_hand.disable_hand()
	start_turn()


func draw_card() -> void:
	trump_card_hand.add_card(character.trump_card_pile.draw_card())


func draw_cards(amount: int) -> void:
	var tween: Tween = create_tween()
	for i: int in range(amount):
		tween.tween_callback(draw_card)
		tween.tween_interval(HAND_DRAW_INTERVAL)
	
	tween.finished.connect(
		func() -> void: Events.player_hand_drawn.emit()
	)
