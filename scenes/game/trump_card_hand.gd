class_name TrumpCardHand
extends HBoxContainer


func _ready() -> void:
	for child: Node in get_children():
		var card_ui: TrumpCardUI = child as TrumpCardUI
		card_ui.parent = self
		card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)


func _on_card_ui_reparent_requested(child: TrumpCardUI) -> void:
	child.reparent(self)
