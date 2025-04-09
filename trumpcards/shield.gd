extends TrumpCard

var block_effect: BlockEffect = BlockEffect.new()


func apply_effects(targets: Array[Node]) -> void:
	block_effect.amount = 1
	block_effect.execute(targets)


func on_remove(played_by: Player) -> void:
	block_effect.on_remove(played_by)
