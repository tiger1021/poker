extends Label

var rng = RandomNumberGenerator.new()

@export var score: int:
	set(value):
		score = value
		_set_score_string()
		
var score_string:String

func _set_score_string():
	var temp_score_string = "%010d" % score
	var score_string = ""
	for x in temp_score_string.length():
		if (x+2)%3 == 0:
			if (x > 1):
				score_string += ","
		score_string += temp_score_string[x]
	
	self.text = score_string
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 0
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
