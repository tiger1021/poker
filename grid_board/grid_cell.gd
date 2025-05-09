class_name GridCell extends TextureRect

@export var card:Card
@export var column:int
@export var row:int
var fstring = "res://cards/pngs/%s.png"

func _ready():
	self.custom_minimum_size = Vector2(80,116)
	self.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	self.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
func load_texture() -> void:
	var card_texture
	if self.card:
		card_texture = load(fstring % self.card.display_name())
	else:
		card_texture =  load("res://cards/pngs/blank.png")
	texture = card_texture
