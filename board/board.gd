class_name Board extends Node2D

@export var columns:int = 5
@export var rows:int = 5

@export var row_height:float
@export var column_width:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	row_height = get_viewport().size.y/rows
	column_width = get_viewport().size.x/columns
	print(row_height)
	print(column_width)

	var suits = ["♦","♠","♥", "♣"]
	var possible_values = [1,2,3,4,5,6,7,8,9,10,11,12,13]
	for row in range(rows):
		for col in range(columns):
			var location = "%s, %s"
			var slot = Slot.new()
			self.add_child(slot)
			slot.row = row
			slot.column = col
			var card = Card.new()
			card.suit = suits.pick_random()
			card.value = possible_values.pick_random()
			slot.card = card
			slot.load_texture()
			slot.scale.x = column_width/slot.texture.get_width()
			slot.scale.y = row_height/slot.texture.get_height()
			if (slot.scale.x > slot.scale.y):
				slot.scale.x = slot.scale.y
			if (slot.scale.y > slot.scale.x):
				slot.scale.y = slot.scale.x
			slot.transform.origin = Vector2(col*column_width,(1 + row)*row_height)
			print(slot.transform.origin)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
