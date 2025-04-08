extends TrumpCard


func apply_effects(targets: Array[Node]) -> void:
	var block_effect: BlockEffect = BlockEffect.new()
	block_effect.amount = 1
	block_effect.execute(targets)
