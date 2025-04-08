extends Node2D

const ARC_POINTS: int = 8

@onready var area_2d: Area2D = $Area2D
@onready var card_arc: Line2D = $CanvasLayer/CardArc

var current_card: TrumpCardUI
var targeting: bool = false

func _ready() -> void:
	Events.trump_card_aim_started.connect(_on_card_aim_started)
	Events.trump_card_aim_ended.connect(_on_card_aim_ended)


func _process(_delta: float) -> void:
	if not targeting:
		return
	
	area_2d.position = get_local_mouse_position()
	card_arc.points = _get_points()


func _get_points() -> Array:
	var points: Array[Vector2] = []
	var start: Vector2 = current_card.global_position
	start.x += current_card.size.x / 2
	var target: Vector2 = get_local_mouse_position()
	var distance: Vector2 = target - start
	
	for i: int in range(ARC_POINTS):
		var t: float = 1. / ARC_POINTS * i
		var x: float = start.x + (distance.x / ARC_POINTS) * i
		var y: float = start.y + ease_out_cubic(t) * distance.y
		points.append(Vector2(x, y))
	
	points.append(target)
	
	return points


func ease_out_cubic(x: float) -> float:
	return 1. - pow(1. - x, 3.)


func _on_card_aim_started(card: TrumpCardUI) -> void:
	if not card.card.is_single_targeted():
		return
	
	targeting = true
	area_2d.monitoring = true
	area_2d.monitorable = true
	current_card = card


func _on_card_aim_ended(card: TrumpCardUI) -> void:
	targeting = false
	card_arc.clear_points()
	area_2d.position = Vector2.ZERO
	area_2d.monitoring = false
	area_2d.monitorable = false
	current_card = null


func _on_area_2d_area_entered(area: Area2D) -> void:
	if not current_card or not targeting:
		return
	
	if not current_card.targets.has(area):
		current_card.targets.append(area)


func _on_area_2d_area_exited(area: Area2D) -> void:
	if not current_card or not targeting:
		return
	
	current_card.targets.erase(area)
