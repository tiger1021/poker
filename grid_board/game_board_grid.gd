extends GridContainer

@export var rows:int = 8
var active_card:Card
var active_cell:GridCell

# variables used to keep track of game state
var game_tick_rate = 1 #seconds
var tick_progress = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for row in range(rows):
		for col in range(columns):
			var location = "%s, %s"
			var grid_cell = GridCell.new()
			self.add_child(grid_cell)
			grid_cell.row = row
			grid_cell.column = col
			if ((grid_cell.row == 0) && (grid_cell.column == self.columns/2)):
				self.generate_card_for_cell(grid_cell)
				active_cell = grid_cell
				active_card = grid_cell.card
			grid_cell.load_texture()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	tick_progress += delta
	if (tick_progress >= 1):
		tick_progress = 0
		set_next_active_cell()
	pass

func start_new_drop() -> void:
	print("New Drop")
func set_next_active_cell() -> void:
	if (active_cell.row < (self.rows - 1)):
		var next_row = active_cell.row + 1
		var next_cell:GridCell
		for cell in self.get_children():
			if ((cell.row == next_row) && (cell.column == active_cell.column)):
				next_cell = cell
				break
		if (next_cell.card == null):
			next_cell.card = active_card
			next_cell.load_texture()
			active_cell.card = null
			active_cell.load_texture()
			active_cell = next_cell
	else:
		start_new_drop()

	
func generate_card_for_cell(grid_cell:GridCell) -> void:
	var suits = ["♦","♠","♥", "♣"]
	var possible_values = [1,2,3,4,5,6,7,8,9,10,11,12,13]
	var card = Card.new()
	card.suit = suits.pick_random()
	card.value = possible_values.pick_random()
	grid_cell.card = card
	
