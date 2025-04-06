extends ColorRect

@export var value = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# eventually when i have sprites this will change the sprite
func set_value(val: int) -> void:
	value = val
	$Label.text = str(value)

func hide_value() -> void:
	$Label.visible = false
	
func show_value() -> void:
	$Label.visible = true
