class_name StatsUI
extends HBoxContainer

@onready var block: HBoxContainer = $Block
@onready var block_label: Label = $Block/BlockLabel
@onready var health: HBoxContainer = $Health
@onready var health_label: Label = $Health/HealthLabel
@onready var attack: HBoxContainer = $Attack
@onready var attack_label: Label = $Attack/AttackLabel



func update_stats(stats: Stats) -> void:
	block_label.text = str(stats.block)
	health_label.text = str(stats.health)
	attack_label.text = str(stats.attack)
	
	
	block.visible = stats.block > 0
	health.visible = stats.health > 0
	attack.visible = stats.attack > 0
