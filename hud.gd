extends CanvasLayer

signal hit
signal stay

var playerScore: int = 0
var oppScore: int = 0
const scoreFormatString: String = "AI: %s\nYou: %s"
const turnTrackerFormatString: String = "Current Turn: %s"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ScoreLabel.text = scoreFormatString % [str(oppScore), str(playerScore)]
	$TurnTrackerLabel.text = turnTrackerFormatString % ["You"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func display_info(text: String) -> void:
	$InfoLabel.text = text
	$InfoLabel.visible = true
	$InfoTimer.start()


func updateScore(player1: int, player2: int) -> void:
	playerScore = player1
	oppScore = player2
	$ScoreLabel.text = scoreFormatString % [str(oppScore), str(playerScore)]


func _on_hit_button_pressed() -> void:
	hit.emit()


func _on_stay_button_pressed() -> void:
	stay.emit()


func _on_info_timer_timeout() -> void:
	$InfoLabel.visible = false
