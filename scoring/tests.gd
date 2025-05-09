extends TextEdit

var evaluator = Evaluator.new()
var suits = ["♦","♠","♥", "♣"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	test_slicer()
	#test_hands()

func test_slicer() -> void:
	var array = [1,2,3,4,5,6,7,8,9,10]
	var group_size = 2
	for x in range(0,array.size() - (group_size - 1)):
		var new_array = array.slice(x,x+group_size)
		print(new_array)
		
func test_hands() -> void:
	self.text += "Starting Tests\n"
	
	for hand in hands:
		self.text += hand
		self.text += "\n"
		self.text += " ".join(hands[hand]["hand"])
		self.text += "\n"
		var score = evaluator.evaluate_hand(create_hand_from_text(hands[hand]["hand"]))
		if (score == evaluator.scoring_table[hand]):
			self.text += "Success\n"
		else:
			self.text += "Failed\n"
		self.text += "-----\n"

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
		"hand": ["10♦", "J♦", "Q♦", "K♦", "A♦"]
	},
	"Straight Flush": {
		"hand": ["2♦", "3♦", "4♦", "5♦", "6♦"]
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
		"hand": ["2♦", "3♦", "4♦", "5♠", "6♦"]
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
