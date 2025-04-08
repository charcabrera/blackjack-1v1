class_name CardPile
extends Resource

signal card_pile_size_changed(cards_amount: int)

@export var cards: Array[BJCard] = []


func empty() -> bool:
	return cards.is_empty()


func draw_card() -> BJCard:
	var idx: int = randi_range(0, cards.size()-1)
	var card: BJCard = cards.pop_at(idx)
	card_pile_size_changed.emit(cards.size())
	return card
