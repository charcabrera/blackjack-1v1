class_name GameUI
extends CanvasLayer

@export var player_stats: Stats: set = _set_char_stats

@onready var hand: TrumpCardHand = $TrumpCardHand as TrumpCardHand
@onready var stay_button: Button = %StayButton


func _ready() -> void:
	Events.player_hand_drawn.connect(_on_player_hand_drawn)
	stay_button.pressed.connect(_on_stay_button_pressed)


func _set_char_stats(value: Stats) -> void:
	player_stats = value
	hand.player_stats = player_stats


func _on_player_hand_drawn() -> void:
	stay_button.disabled = false


func _on_stay_button_pressed() -> void:
	stay_button.disabled = true
	Events.player_turn_ended.emit()
