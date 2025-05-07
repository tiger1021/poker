extends CenterContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var evaluator = Evaluator.new()
	
	print("Starting Tests")
	var suits = ["♦","♠","♥", "♣"]
	
	print("Invalid Hand")
	var hand_text = ["2♦", "3♦", "3♦", null, "10♦"]
	print(var_to_str(hand_text))
	var hand = create_hand_from_text(hand_text)
	if (evaluator.evaluate_hand(hand) == 0):
		print("Passed")
	else:
		print("Failed")
		
	print("Flush")
	hand_text = ["3♦", "2♦", "9♦", "8♦", "10♦"]
	print(var_to_str(hand_text))
	hand = create_hand_from_text(hand_text)
	if (evaluator.evaluate_hand(hand) == 100):
		print("Passed")
	else:
		print("Failed")
		
	print("Straight")
	hand_text = ["3♦", "4♥", "5♦", "6♦", "7♣"]
	print(var_to_str(hand_text))
	hand = create_hand_from_text(hand_text)
	if (evaluator.evaluate_hand(hand) == 200):
		print("Passed")
	else:
		print("Failed")
		
	pass # Replace with function body.

func create_hand_from_text(cards) -> Array:
	var hand = []
	for card in cards:
		if (card != null):
			var new_card = Card.new()
			new_card.suit = card[-1]
			new_card.value = int(card.split(card[-1])[0])
			hand.append(new_card)
		else:
			hand.append(null)
	return hand

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass
