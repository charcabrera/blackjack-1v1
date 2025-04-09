extends Node2D


@export var player_stats: Stats

@onready var game_ui: CanvasLayer = $GameUI
@onready var player_handler: PlayerHandler = $PlayerHandler
@onready var player: Player = $Player


func _ready() -> void:
	var new_stats: Stats = player_stats.create_instance()
	game_ui.player_stats = new_stats
	player.stats = new_stats
	
	Events.player_turn_ended.connect(player_handler.end_turn)
	
	start_battle(new_stats)


func start_battle(new_stats: Stats) -> void:
	player_handler.start_battle(player_stats)
	player_handler.draw_cards(player_stats.cards_per_turn)
