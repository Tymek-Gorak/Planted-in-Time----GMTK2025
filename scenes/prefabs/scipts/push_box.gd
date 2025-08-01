extends CharacterBody2D
class_name PushBox

const PUSH_FORCE = 20

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

func _physics_process(_delta: float) -> void:
	if not velocity.is_zero_approx():
		if abs(velocity.x) > abs(velocity.y):
			velocity = sign(velocity.x) * PUSH_FORCE * Vector2.RIGHT
		elif abs(velocity.x) < abs(velocity.y):
			velocity = sign(velocity.y) * PUSH_FORCE * Vector2.DOWN
	move_and_slide()
	velocity = Vector2.ZERO

func time_loop():
	if cancel_loop:
		cancel_loop = false
		return


	position = starting_position
