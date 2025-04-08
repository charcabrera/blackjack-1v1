extends CardState


func enter() -> void:
	if not trumpcard_ui.is_node_ready():
		await trumpcard_ui.ready
	
	if trumpcard_ui.tween and trumpcard_ui.tween.is_running():
		trumpcard_ui.tween.kill()
	
	trumpcard_ui.background.set("theme_override_styles/panel", trumpcard_ui.BASE_STYLE)
	trumpcard_ui.reparent_requested.emit(trumpcard_ui)
	#trumpcard_ui.color.color = Color.GOLD
	#trumpcard_ui.state.text = "BASE"
	trumpcard_ui.pivot_offset = Vector2.ZERO


func on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		trumpcard_ui.pivot_offset = trumpcard_ui.get_global_mouse_position() - trumpcard_ui.global_position
		transition_requested.emit(self, CardState.State.CLICKED)


func on_mouse_entered() -> void:
	trumpcard_ui.background.set("theme_override_styles/panel", trumpcard_ui.HOVER_STYLE)


func on_mouse_exited() -> void:
	trumpcard_ui.background.set("theme_override_styles/panel", trumpcard_ui.BASE_STYLE)
