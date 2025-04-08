class_name TrumpCardPile
extends Resource

signal trump_card_pile_size_changed(cards_amount: int)

@export var cards: Array[TrumpCard] = []


func empty() -> bool:
	return cards.is_empty()


func draw_card() -> TrumpCard:
	var idx: int = randi_range(0, cards.size()-1)
	var card: TrumpCard = cards.pop_at(idx)
	trump_card_pile_size_changed.emit(cards.size())
	return card
