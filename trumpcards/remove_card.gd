extends TrumpCard


func apply_effects(targets: Array[Node]) -> void:
	var remove_effect: RemoveEffect = RemoveEffect.new()
	remove_effect.execute(targets)
