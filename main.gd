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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_round()


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
	add_child(card)


func sum_array(array):
	var sum: int = 0
	for element in array:
		sum += element
	return sum


func draw_card_player() -> void:
	# can be int or null
	var card = get_random_card()
	# early return guard clause
	if card == -1:
		$HUD.display_info("No cards left in the deck.")
		return
	
	p1hand.append(card)
	spawn_card(card, $P1HandPath/CardSpawnLocation)
	playerScore = sum_array(p1hand)
	$HUD.updateScore(playerScore, oppScore)
	# can be int or null


func draw_card_opp(hidden: bool = false) -> void:
	
	var card = get_random_card()
	# early return guard clause
	if card == -1:
		$HUD.display_info("No cards left in the deck.")
		return
		
	p2hand.append(card)
	spawn_card(card, $P2HandPath/CardSpawnLocation, hidden)
	oppScore = sum_array(p2hand)
	$HUD.updateScore(playerScore, oppScore)


func reset_game() -> void:
	p1hand.clear()
	p2hand.clear()
	generate_deck()
	playerScore = 0
	oppScore = 0
	turn = TURNS.PLAYER

func start_round() -> void:
	reset_game()
	draw_card_player()
	draw_card_opp(true)
	draw_card_player()
	draw_card_opp()


func _on_hud_hit() -> void:
	draw_card_player()


func _on_debug_menu_hit() -> void:
	draw_card_opp()


func _on_debug_menu_stay() -> void:
	pass # Replace with function body.
