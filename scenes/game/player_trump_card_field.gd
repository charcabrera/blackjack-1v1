extends HBoxContainer

const PLAYED_TRUMP_CARD: PackedScene = preload("res://selectables/played_trump_card.tscn")
@onready var player: Player = %Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.player_card_played.connect(_on_card_played)


func _on_card_played(card: TrumpCard) -> void:
	var played_card: PlayedTrumpCard = PLAYED_TRUMP_CARD.instantiate()
	played_card.card = card
	played_card.played_by = %Player
	add_child(played_card)
