extends CenterContainer
class_name Scoreboard
@export var scoring_hands_queue:Array
@export var game_board_grid:GameBoardGrid

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.scoring_hands_queue = Array()
	pass # Replace with function body.

func add_hands(hands) -> void:
	for hand in hands:
		scoring_hands_queue.append(hand)
		
func process_queue() -> void:
	var score_matrix:ScoreMatrix = get_node("%score_matrix")
	for hand in self.scoring_hands_queue:
		score_matrix.score += hand.score
		game_board_grid.clear_hand(hand)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
