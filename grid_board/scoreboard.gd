class_name Scoreboard extends RichTextLabel

@export var score:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.text = str(score)
	pass
