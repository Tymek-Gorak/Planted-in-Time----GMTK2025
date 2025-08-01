extends Camera2D

@onready var player : Player = get_tree().get_first_node_in_group("Player")

func switch_screen(direction : Vector2):
	if abs(direction.x) > abs(direction.y):
		direction = Vector2.RIGHT * sign(direction.x)
	else:
		direction = Vector2.DOWN * sign(direction.y)

	var tween = create_tween().set_ease(Tween.EASE_OUT)
	if direction.x != 0:
		tween.tween_property(self, ^"position", position + direction * get_viewport_rect().size.x, 0.2)
	else:
		tween.tween_property(self, ^"position", position + direction * get_viewport_rect().size.y, 0.2)
