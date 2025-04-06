extends Node

enum TURNS {PLAYER, AI}

@export var card_scene: PackedScene
var deck: Array = Array()
var p1hand: Array = Array()
var p2hand: Array = Array()
var turn: TURNS = TURNS.PLAYER
var playerScore: int = 0
var oppScore: int = 0
var stayed: bool = false
var playTo: int = 21
var hiddenCard: Node
var roundOver: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_new_round()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func generate_deck() -> void:
	deck.clear()
	for i in range(11):
		deck.append(i+1)


# will return int or null
func get_random_card():
	if deck.is_empty():
		return -1
	var val: int = deck.pick_random()
	deck.erase(val)
		
	return val


func spawn_card(value: int, path: PathFollow2D, hidden: bool = false) -> void:
	var card: Node = card_scene.instantiate()
	card.set_value(value)
	card.position = path.position
	path.progress += 75+5
	if hidden:
		card.hide_value()
		hiddenCard = card
	add_child(card)


func sum_array(array):
	var sum: int = 0
	for element in array:
		sum += element
	return sum


func draw_card_player() -> void:
	if not turn == TURNS.PLAYER:
		$HUD.display_info("You can only hit on your turn.")
		return
	if playerScore > playTo:
		$HUD.display_info("You can't hit when you're bust.")
		return
	# can be int or null
	stayed = false
	var card = get_random_card()
	# early return guard clause
	if card == -1:
		$HUD.display_info("No cards left in the deck.")
		return
	$CardSoundPlayer.play()
	
	p1hand.append(card)
	spawn_card(card, $P1HandPath/CardSpawnLocation)
	playerScore = sum_array(p1hand)
	$HUD.updateScore(playerScore, oppScore)


func draw_card_opp(hidden: bool = false) -> void:
	stayed = false
	var card = get_random_card()
	# early return guard clause
	if card == -1:
		$HUD.display_info("No cards left in the deck.")
		return
	$CardSoundPlayer.play()
		
	p2hand.append(card)
	spawn_card(card, $P2HandPath/CardSpawnLocation, hidden)
	oppScore = sum_array(p2hand.slice(1))
	$HUD.updateScore(playerScore, oppScore)


func next_turn() -> void:
	if turn == TURNS.PLAYER:
		turn = TURNS.AI
		$HUD.set_turn("Opponent")
	else:
		turn = TURNS.PLAYER
		$HUD.set_turn("You")
	


func reset_round() -> void:
	p1hand.clear()
	p2hand.clear()
	generate_deck()
	playerScore = 0
	oppScore = 0
	turn = TURNS.PLAYER
	get_tree().call_group("cards", "queue_free")
	$HUD.updateScore(playerScore, oppScore)
	$P1HandPath/CardSpawnLocation.progress = 0
	$P2HandPath/CardSpawnLocation.progress = 0
	hiddenCard = null
	roundOver = false


func start_new_round() -> void:
	reset_round()
	draw_card_player()
	draw_card_opp(true)
	draw_card_player()
	draw_card_opp()
	playTo = 21


func showdown() -> void:
	if roundOver:
		return
	hiddenCard.show_value()
	$CardSoundPlayer.play()
	playerScore = sum_array(p1hand)
	oppScore = sum_array(p2hand)
	$HUD.showdownScore(playerScore, oppScore)
	if playerScore <= playTo and (playerScore > oppScore or oppScore > playTo):
		$HUD.display_info("Player wins.")
	elif oppScore <= playTo and (oppScore > playerScore or playerScore > playTo):
		$HUD.display_info("Opponent wins.")
	else:
		$HUD.display_info("Draw.")
	roundOver = true


func ai_stay() -> void:
	print('here')
	if not turn == TURNS.AI:
		return
	if stayed == true:
		showdown()
		return
	else:
		stayed = true
		next_turn()


func _on_hud_hit() -> void:
	draw_card_player()

func _on_hud_stay() -> void:
	if not turn == TURNS.PLAYER:
		return
	if stayed == true:
		showdown()
		return
	else:
		stayed = true
		next_turn()


func _on_debug_menu_hit() -> void:
	draw_card_opp()


func _on_debug_menu_stay() -> void:
	ai_stay()


func _on_debug_menu_reset() -> void:
	reset_round()


func _on_debug_menu_showdown() -> void:
	showdown()


func _on_debug_menu_start() -> void:
	start_new_round()
