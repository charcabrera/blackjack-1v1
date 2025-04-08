extends CardState

var played: bool

func enter() -> void:
	trumpcard_ui.color.color = Color.DARK_VIOLET
	trumpcard_ui.state.text = "RELEASED"

	played = false
	
	if not trumpcard_ui.targets.is_empty():
		played = true
		print("play card for target(s) ", trumpcard_ui.targets)


func on_input(_event: InputEvent) -> void:
	if played:
		return
	
	transition_requested.emit(self, CardState.State.BASE)
