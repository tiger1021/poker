class_name Card extends Node

@export var suit:String
@export var value:int
	
func display_name() -> String:
	var fstring = "%s%s"
	var val_string = str(self.value)
	match value:
		11:
			val_string = "J"
		12:
			val_string = "Q"
		13:
			val_string = "K"
		14:
			val_string = "A"
	return(fstring % [val_string, self.suit])
