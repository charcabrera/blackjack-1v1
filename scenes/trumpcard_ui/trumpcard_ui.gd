class_name TrumpCardUI
extends Control

signal reparent_requested(which_card_ui: TrumpCardUI)

const BASE_STYLE: StyleBoxFlat = preload("res://scenes/trumpcard_ui/card_base_style.tres")
const DRAG_STYLE: StyleBoxFlat = preload("res://scenes/trumpcard_ui/card_drag_style.tres")
const HOVER_STYLE: StyleBoxFlat = preload("res://scenes/trumpcard_ui/card_hover_style.tres")

@export var card: TrumpCard: set = _set_card

@onready var background: Panel = $Background
@onready var icon: TextureRect = $Icon
@onready var drop_point_detector: Area2D = $DropPointDetector
@onready var card_state_machine: CardStateMachine = $CardStateMachine as CardStateMachine
@onready var targets: Array[Node] = []
@onready var original_index: int = self.get_index()

var parent: Control
var tween: Tween
var playable: bool = true: set = _set_playable
var disabled: bool = false

func _ready() -> void:
	Events.trump_card_aim_started.connect(_on_card_drag_or_aiming_started)
	Events.trump_card_drag_started.connect(_on_card_drag_or_aiming_started)
	Events.trump_card_aim_ended.connect(_on_card_drag_or_aiming_ended)
	Events.trump_card_drag_ended.connect(_on_card_drag_or_aiming_ended)
	card_state_machine.init(self)


func _input(event: InputEvent) -> void:
	card_state_machine.on_input(event)


func play() -> void:
	if not card:
		return
	print(targets)
	card.play(targets)
	if card.type == TrumpCard.Type.CONSUME:
		queue_free()
	else:
		return


func animate_to_position(new_position: Vector2, duration: float) -> void:
	tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", new_position, duration)


func _set_playable(val: bool) -> void:
	playable = val
	if not playable:
		self.modulate = Color(1, 1, 1, .5)
	else:
		self.modulate = Color(1, 1, 1, 1)


func _on_card_drag_or_aiming_started(used_card: TrumpCardUI) -> void:
	if used_card == self:
		return
	
	disabled = true


func _on_card_drag_or_aiming_ended(used_card: TrumpCardUI) -> void:
	disabled = false
	self.playable = true


func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)


func _on_mouse_entered() -> void:
	card_state_machine.on_mouse_entered()


func _on_mouse_exited() -> void:
	card_state_machine.on_mouse_exited()


func _on_drop_point_detector_area_entered(area: Area2D) -> void:
	if not targets.has(area):
		targets.append(area)


func _on_drop_point_detector_area_exited(area: Area2D) -> void:
	targets.erase(area)


func _set_card(val: TrumpCard) -> void:
	if not is_node_ready():
		await ready
	
	card = val
	icon.texture = val.icon
	
