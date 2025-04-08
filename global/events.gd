extends Node

# Trump Card-related events
signal trump_card_drag_started(trump_card_ui: TrumpCardUI)
signal trump_card_drag_ended(trump_card_ui: TrumpCardUI)
signal trump_card_aim_started(trump_card_ui: TrumpCardUI)
signal trump_card_aim_ended(trump_card_ui: TrumpCardUI)
signal card_played(trump_card: TrumpCard)
