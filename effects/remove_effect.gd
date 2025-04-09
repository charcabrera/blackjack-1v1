class_name RemoveEffect
extends Effect


func execute(targets: Array[Node]) -> void:
	for target: Node in targets:
		if not target:
			continue
		if target is PlayedTrumpCard:
			target.queue_free()
