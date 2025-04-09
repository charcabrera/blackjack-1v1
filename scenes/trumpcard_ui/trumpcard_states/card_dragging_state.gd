extends CardState

const DRAG_MINIMUM_THRESHOLD: float = .05

var minimum_drag_time_elapsed: bool = false


func enter() -> void:
	var ui_layer: CanvasLayer = get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		trumpcard_ui.reparent(ui_layer)
	
	#trumpcard_ui.color.color = Color.NAVY_BLUE
	#trumpcard_ui.state.text = "DRAGGING"
	Events.trump_card_drag_started.emit(trumpcard_ui)
	
	trumpcard_ui.background.set("theme_override_styles/panel", trumpcard_ui.DRAG_STYLE)
	
	minimum_drag_time_elapsed = false
	var threshold_timer: SceneTreeTimer = get_tree().create_timer(DRAG_MINIMUM_THRESHOLD, false)
	threshold_timer.timeout.connect(func() -> void: minimum_drag_time_elapsed = true)


func exit() -> void:
	Events.trump_card_drag_ended.emit(trumpcard_ui)


func on_input(event: InputEvent) -> void:
	var single_targeted: bool = trumpcard_ui.card.is_single_targeted()
	var mouse_motion: bool = event is InputEventMouseMotion
	var cancel: bool = event.is_action_pressed("right_mouse")
	var confirm: bool = (event.is_action_released("left_mouse") and minimum_drag_time_elapsed) or event.is_action_pressed("left_mouse")
	
	if single_targeted and mouse_motion and trumpcard_ui.targets.size() > 0:
		transition_requested.emit(self, CardState.State.AIMING)
		return
	
	if mouse_motion:
		trumpcard_ui.global_position = trumpcard_ui.get_global_mouse_position() - trumpcard_ui.pivot_offset
	
	if cancel:
		transition_requested.emit(self, CardState.State.BASE)
	elif confirm:
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)
