extends StaticBody2D
class_name TimeLooper


var cancel_loop := false:
	set(value):
		if value == true:
			modulate = Color.PURPLE
		else:
			modulate = Color.WHITE
		cancel_loop = value

@onready var starting_position := position

func _ready() -> void:
	add_to_group("time_loopables")


func time_loop():
	if cancel_loop:
		cancel_loop = false
		return
