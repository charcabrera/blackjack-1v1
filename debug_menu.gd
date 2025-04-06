extends CanvasLayer

signal hit
signal stay
signal showdown
signal reset
signal start

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func _on_ai_hit_button_pressed() -> void:
	hit.emit()


func _on_ai_stay_button_pressed() -> void:
	stay.emit()


func _on_showdown_button_pressed() -> void:
	showdown.emit()


func _on_reset_button_pressed() -> void:
	reset.emit()


func _on_start_new_round_button_pressed() -> void:
	start.emit()
