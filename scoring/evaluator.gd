class_name Evaluator extends Node

func evaluate_hands(array:Array) -> Array:
	var hands = Array()
	var scoring_hands = Array()
	var group_size = 5
	for x in range(0,array.size() - (group_size - 1)):
		var cells = array.slice(x,x+group_size)
		var hand = Hand.new()
		for cell in cells:
			hand.grid_cells.append(cell)

		if self.evaluate_hand(hand).size() > 0:
			var evaluation = self.evaluate_hand(hand)
			hand.score = evaluation.values()[0]
			hand.score_name = evaluation.keys()[0]
			scoring_hands.append(hand)
	
	return scoring_hands
		
		
func evaluate_hand(hand:Hand) -> Dictionary:
	var values = Dictionary()
	var cards = Array()
	for cell in hand.grid_cells:
		cards.append(cell.card)
	cards.sort_custom(sort_hand_ascending)
	var valid = true
	var is_straight = true
	var is_flush = false
	var pairs = 0
	var triplet = 0
	var quad = 0
	var multiples = {}
	var suits = {}

	for index in cards.size():
		var card = cards[index]
		if (card==null):
			is_straight = false
			valid = false
			break
		else:
			if (multiples.get(card.value) == null):
				multiples[card.value] = 1
			else:
				multiples[card.value] = multiples[card.value] + 1
			suits[card.suit] = 1
			if index < 4:
				if cards[index].value != (cards[index+1].value - 1):
					is_straight = false
			
	#if (valid==false):
	
	if (suits.keys().size() == 1):
		is_flush = true
		values = {"Flush": scoring_table["Flush"]}
	
	if is_straight == true:
		if is_flush == true:
			if (cards[0].value == 10):
				values = {"Royal Flush": scoring_table["Royal Flush"]}

			else:
				values = {"Straight Flush": scoring_table["Straight Flush"]}

		else:
			values = {"Straight": scoring_table["Straight"]}
	
	for multiple in multiples.values():
		if multiple == 2:
			pairs += 1
		if multiple == 3:
			triplet = 1
		if multiple == 4:
			quad = 1
	
	if pairs == 1:
		if triplet == 1:
			values = {"Full House": scoring_table["Full House"]}

		else:
			values = {"One Pair": scoring_table["One Pair"]}

	elif pairs == 2:
		values = {"Two Pair": scoring_table["Two Pair"]}

	else:
		if triplet == 1:
			values = {"Three of a Kind": scoring_table["Three of a Kind"]}

	if quad == 1:
		values = {"Four of a Kind": scoring_table["Four of a Kind"]}
	return values

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
	"Invalid Hand": 0,
	"Flush Bonus": 50
}
