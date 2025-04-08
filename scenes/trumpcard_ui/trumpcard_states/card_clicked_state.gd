extends CardState


func enter() -> void:
	trumpcard_ui.color.color = Color.ORANGE
	trumpcard_ui.state.text = "CLICKED"
	trumpcard_ui.drop_point_detector.monitoring = true


func on_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		transition_requested.emit(self, CardState.State.DRAGGING)
