class_name Evaluator extends Node

func evaluate_hand(hand) -> int:
	hand.sort_custom(sort_hand_ascending)
	var value = 0
	var valid = true
	var is_straight = true
	var is_flush = false
	
	var multiples = {}
	var suits = {}
	for index in hand.size():
		var card = hand[index]
		if (card==null):
			valid = false
			break
		else:
			if (multiples.find_key(card.value) == null):
				multiples[card.value] = 0
			else:
				multiples[card.value] = multiples[card.value] + 1
			suits[card.suit] = 1
			
	if (valid==false):
		value = 0
	
	if (suits.keys().size() == 1):
		is_flush = true
		value = scoring_table["Flush"]
	
	if (multiples.keys().size() > 1):
		print("Has multiples")
			
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
	
@export var scoring_table:Dictionary = {
	"Five of a Kind": 1200,
	"Royal Flush": 1000,
	"Straight Flush": 800,
	"Four of a Kind": 600,
	"Full House": 500,
	"Flush": 400,
	"Straight": 300,
	"Three of a Kind": 200,
	"Two Pair": 100,
	"One Pair": 50,
	"Invalid Hand": 0
}
