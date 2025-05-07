class_name Evaluator extends Node

func evaluate_hand(hand) -> int:
	hand.sort_custom(sort_hand_ascending)
	var value = 0
	var valid = true
	var is_straight = true
	var is_flush = false
	var multiples = {}
	var suits = {}
	for card in hand:
		if (card==null):
			valid = false
			break
		else:
			suits[card.suit] = 1
			print(card.suit)
			print(card.value)
			print("---")
	if (valid==false):
		value = 0
	
	if (suits.keys().size() == 1):
		is_flush = true
		value = 100
	return value

func sort_hand_ascending(a, b):
	if (a == null):
		return true
	if (b == null):
		return false
	if a.value < b.value:
		return true
	return false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
