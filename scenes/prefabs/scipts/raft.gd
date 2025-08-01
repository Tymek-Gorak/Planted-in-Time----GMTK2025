extends Node2D
class_name Raft

@export_range(-1,1,1) var starting_position : int

## returns -1 when on the left, 0 in middle, and 1 on the right
var raft_position : int:
	get():
		return time_looper.position.x / 16.0

@onready var time_looper: StaticBody2D = %TimeLooper

func _ready() -> void:
	match starting_position:
		-1:
			move()
			move()
		1:
			move()

func move():
	for child : Node2D in get_children():
		#move tile to the right
		if child.position.x == 16:
			child.position.x *= -1
		else:
			child.position.x += 16

func time_loop():
	while raft_position != starting_position:
		move()
