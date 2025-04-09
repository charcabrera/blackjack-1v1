class_name PlayedTrumpCard
extends Area2D

@export var art: Texture2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var arrow: Sprite2D = $Arrow
@onready var card: TrumpCard
@onready var played_by: Player


func update_card() -> void:
	if not is_inside_tree():
		await ready
	
	sprite_2d.texture = art


func destroy() -> void:
	card.on_remove(played_by)
	queue_free()


func _on_area_entered(_area: Area2D) -> void:
	arrow.visible = true


func _on_area_exited(_area: Area2D) -> void:
	arrow.visible = false
