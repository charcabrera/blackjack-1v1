class_name Stats
extends Resource

signal stats_changed

@export var max_health: int = 1
@export var cards_per_turn: int
@export var art: Texture2D

var health: int: set = set_health
var block: int: set = set_block
var attack: int = 1: set = set_attack
var hand: TrumpCardPile
var bj_hand: CardPile
var trump_card_pile: TrumpCardPile


func set_health(value: int) -> void:
	health = clampi(value, 0, max_health)
	stats_changed.emit()


func set_block(value: int) -> void:
	block = clampi(value, 0, 999)
	stats_changed.emit()


func set_attack(value: int) -> void:
	attack = clampi(value, 0, 999)
	stats_changed.emit()


func take_damage(damage: int) -> void:
	if damage <= 0:
		return
	var initial_damage: int = damage
	damage = clampi(damage - block, 0, damage)
	self.block = clampi(block - initial_damage, 0, block)
	self.health -= damage


func heal(amount: int) -> void:
	self.health += amount


func create_instance() -> Resource:
	var instance: Stats = self.duplicate()
	instance.health = max_health
	instance.block = 0
	instance.hand = TrumpCardPile.new()
	instance.bj_hand = CardPile.new()
	instance.trump_card_pile = TrumpCardPile.new()
	return instance
