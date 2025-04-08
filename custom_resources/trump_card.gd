class_name TrumpCard
extends Resource

enum Type {CONSUME, REMAIN}
enum Target {SELF, SINGLE_CARD, OPPONENT, EVERYONE}

@export_group("Card Attributes")
@export var id: String
@export var type: Type
@export var target: Target


func is_single_targeted() -> bool:
	return target == Target.SINGLE_CARD

func remains() -> bool:
	return type == Type.REMAIN
