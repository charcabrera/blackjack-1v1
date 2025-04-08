class_name TrumpCard
extends Resource

enum Type {CONSUME, REMAIN}
enum Target {SELF, SINGLE_CARD, OPPONENT, EVERYONE}

@export_group("Card Attributes")
@export var id: String
@export var type: Type
@export var target: Target

@export_group("Card Visuals")
@export var icon: Texture2D
@export_multiline var tooltip_text: String



func is_single_targeted() -> bool:
	return target == Target.SINGLE_CARD


func remains() -> bool:
	return type == Type.REMAIN


func _get_targets(targets: Array[Node]) -> Array[Node]:
	if not targets:
		return []
	
	var tree: SceneTree = targets[0].get_tree()
	
	match target:
		Target.SELF:
			return tree.get_nodes_in_group("player")
		Target.SINGLE_CARD:
			return tree.get_nodes_in_group("playedtrumpcards")
		_:
			return []


func play(targets: Array[Node]) -> void:
	Events.card_played.emit(self)
	
	if is_single_targeted():
		print('here')
		apply_effects(targets)
	else:
		apply_effects(_get_targets(targets))


func apply_effects(_targets: Array[Node]) -> void:
	pass
