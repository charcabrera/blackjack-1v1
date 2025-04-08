class_name BlockEffect
extends Effect

var amount: int = 0


func execute(targets: Array[Node]) -> void:
	for target: Node in targets:
		if not target:
			continue
		if target is Player:
			target.stats.block += amount
