class_name Slot extends TextureRect

@export var card:Card
@export var column:int
@export var row:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func load_texture() -> void:
	var fstring = "res://cards/pngs/%s.png"
	var card_texture
	if self.card:
		card_texture = load(fstring % self.card.display_name())
	else:
		card_texture =  load("res://cards/pngs/blank.png")

	texture = card_texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
