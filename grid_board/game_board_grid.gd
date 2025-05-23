extends GridContainer
class_name GameBoardGrid

@export var rows:int = 8
var active_card:Card
var active_cell:GridCell
var grid_array = Array()
var score:int = 0
var evaluator:Evaluator
var processing_queue:bool = false

# Grid array is an array of rows.
# grid_array[0] is the topmost row
# grid_array[0][0] is the upper left cell
# grid_array[rows-1][columns-1] is lower right cell

# variables used to keep track of game state
var game_tick_rate = 1 #seconds
var tick_progress = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	evaluator = Evaluator.new()
	grid_array.resize(rows)
	for row in range(rows):
		var row_array = Array()
		row_array.resize(columns)
		grid_array[row] = row_array
		for col in range(columns):
			var grid_cell = GridCell.new()
			self.add_child(grid_cell)
			grid_cell.row = row
			grid_cell.column = col
			@warning_ignore("integer_division")
			if ((grid_cell.row == 0) && (grid_cell.column == self.columns/2)):
				self.generate_card_for_cell(grid_cell)
				active_cell = grid_cell
				active_card = grid_cell.card
			grid_cell.load_texture()
			row_array[col] = grid_cell
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if processing_queue == false:
		tick_progress += delta
		if (tick_progress >= game_tick_rate):
			tick_progress = 0
			move_down()
	pass

func check_for_winning_hands() -> void:
	var scoreboard:Scoreboard = get_parent().get_node('%Scoreboard')
	if scoreboard.game_board_grid == null:
		scoreboard.game_board_grid = self
	# Check the rows
	for row in grid_array:
		var count = row.filter(func(cell): return cell.card != null).size()
		if count >= 5:
			scoreboard.add_hands(evaluator.evaluate_hands(row))
	
	# Check the columns
	for column in range(columns):
		var column_array = Array()
		column_array.resize(rows)
		for row in range(rows):
			column_array[row] = grid_array[row][column]
		var count = column_array.filter(func(cell): return cell.card != null).size()
		#if count >= 5:
			#evaluator.slice_hands(column_array)
	scoreboard.process_queue()

func clear_hand(hand:Hand) -> void:
	print("Clear")
	for grid_cell:GridCell in hand.grid_cells:
		grid_cell.card = null
		grid_cell.load_texture()

func start_new_drop() -> void:
	check_for_winning_hands()
	@warning_ignore("integer_division")
	var cell = grid_array[0][self.columns/2]
	self.generate_card_for_cell(cell)
	active_cell = cell
	active_card = cell.card
	active_cell.load_texture()

func generate_card_for_cell(grid_cell:GridCell) -> void:
	var suits = ["♦","♠","♥", "♣"]
	var possible_values = [2,3,4,5,6,7,8,9,10,11,12,13,14]
	var card = Card.new()
	card.suit = suits.pick_random()
	card.value = possible_values.pick_random()
	grid_cell.card = card

func set_active_cell(next_cell:GridCell) -> void:
	var current_texture = active_cell.texture
	var next_texture = next_cell.texture
	next_cell.card = active_card
	next_cell.texture = current_texture
	active_cell.card = null
	active_cell.texture = next_texture
	active_cell = next_cell

# Input Events
func _input(event):
	if event.is_action_pressed("move_right"):
		move_right()
	elif event.is_action_pressed("move_left"):
		move_left()
	elif event.is_action_pressed("move_down"):
		move_down()
		
func move_right() -> void:
	if (active_cell.column < (self.columns - 1)):
		var next_cell = grid_array[active_cell.row][active_cell.column+ 1]
		if (next_cell.card == null):
			set_active_cell(next_cell)
	
func move_left() -> void:
	if (active_cell.column > (0)):
		var next_cell = grid_array[active_cell.row][active_cell.column - 1]
		if (next_cell.card == null):
			set_active_cell(next_cell)
		
func move_down() -> void:
	if (active_cell.row < (rows - 1)):
		var next_cell = grid_array[active_cell.row + 1][active_cell.column]
		if (next_cell.card == null):
			set_active_cell(next_cell)
		else:
			start_new_drop()
	else:
		start_new_drop()
