extends CenterContainer

var evaluator = Evaluator.new()
var suits = ["♦","♠","♥", "♣"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	print("Starting Tests")
	
	for hand in hands:
		print(hand)
		print(hands[hand]["hand"])
		var score = evaluator.evaluate_hand(create_hand_from_text(hands[hand]["hand"]))
		if (score == evaluator.scoring_table[hand]):
			print("Success")
		else:
			print("Failed")
		print("-----")

	pass # Replace with function body.

func create_hand_from_text(cards) -> Array:
	var hand = []
	for card in cards:
		if (card != null):
			var new_card = Card.new()
			new_card.suit = card[-1]
			var card_value = card.split(card[-1])[0]
			match card_value:
				"J":
					card_value = 11
				"Q":
					card_value = 12
				"K":
					card_value = 13
				"A":
					card_value = 14
			new_card.value = int(card_value)
			hand.append(new_card)
		else:
			hand.append(null)
	return hand

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

var hands = {
	"Royal Flush": {
		"hand": ["J♦", "2♦", "3♦", "5♠", "10♦"]
	},
	"Straight Flush": {
		"hand": ["2♦", "2♦", "3♦", "5♠", "10♦"]
	},
	"Four of a Kind": {
		"hand": ["2♦", "2♦", "2♦", "2♠", "10♦"]
	},
	"Full House": {
		"hand": ["2♦", "2♠", "3♦", "3♠", "3♣"]
	},
	"Flush": {
		"hand": ["2♦", "8♦", "3♦", "5♦", "10♦"]
	},
	"Straight": {
		"hand": ["2♦", "2♦", "3♦", "5♠", "10♦"]
	},
	"Three of a Kind": {
		"hand": ["2♦", "2♠", "2♣", "5♠", "10♦"]
	},
	"Two Pair": {
		"hand": ["2♦", "2♠", "3♦", "3♦", "10♦"]
	},
	"One Pair": {
		"hand": ["2♦", "2♠", "3♦", "5♠", "10♦"]
	},
	"Invalid Hand": {
		"hand": ["2♦", "3♦", "3♦", null, "10♦"]
	}
	
}
