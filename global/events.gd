extends Node

# Trump Card-related events
signal trump_card_drag_started(trump_card_ui: TrumpCardUI)
signal trump_card_drag_ended(trump_card_ui: TrumpCardUI)
signal trump_card_aim_started(trump_card_ui: TrumpCardUI)
signal trump_card_aim_ended(trump_card_ui: TrumpCardUI)
signal player_card_played(trump_card: TrumpCard)
signal card_tooltip_requested(trump_card: TrumpCard)
signal tooltip_hide_requested

# Player-related Events
signal player_hand_drawn
signal player_turn_ended
