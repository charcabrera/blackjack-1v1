extends CardState

const MOUSE_Y_SNAPBACK_THRESHOLD: int = 600


func enter() -> void:
	#trumpcard_ui.color.color = Color.WEB_MAROON
	#trumpcard_ui.state.text = "AIMING"
	trumpcard_ui.targets.clear()
	var offset: Vector2 = Vector2(trumpcard_ui.parent.size.x / 2, -trumpcard_ui.size.y / 2)
	offset.x -= trumpcard_ui.size.x / 2
	trumpcard_ui.animate_to_position(trumpcard_ui.parent.global_position + offset, .2)
	trumpcard_ui.drop_point_detector.monitoring = false
	Events.trump_card_aim_started.emit(trumpcard_ui)


func exit() -> void:
	Events.trump_card_aim_ended.emit(trumpcard_ui)


func on_input(event: InputEvent) -> void:
	var mouse_motion: bool = event is InputEventMouseMotion
	var mouse_at_bottom: bool = trumpcard_ui.get_global_mouse_position().y > MOUSE_Y_SNAPBACK_THRESHOLD

	if (mouse_motion and mouse_at_bottom) or event.is_action_pressed("right_mouse"):
		transition_requested.emit(self, CardState.State.BASE)
	elif event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse"):
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)
