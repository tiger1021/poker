class_name Card extends Node

@export var suit:String
@export var value:int
	
func display_name() -> String:
	var fstring = "%s%s"
	var val_string = str(self.value)
	match value:
		1:
			val_string = "A"
		11:
			val_string = "J"
		12:
			val_string = "Q"
		13:
			val_string = "K"
	return(fstring % [val_string, self.suit])
