extends TextureRect
class_name TimeLoopTimer

const FRAME_COUNT = 17

static var starting_time : int = 16
static var time_left := starting_time

var frame := 0:
	set(value):
		frame = clamp(value, 0, FRAME_COUNT - 1)
		change_sprite_to_frame(frame)

@onready var starting_position : Vector2 = position
@onready var texture_atlas : AtlasTexture = texture
@onready var timer: Timer = %Timer

func _second_passed() -> void:
	time_left -= 1

	if frame == FRAME_COUNT-1:
		GameManager.time_loop()
		time_loop()
	if (float(starting_time) / 16) * float(frame) < starting_time - time_left :
		frame+=1

func change_sprite_to_frame(number : int):
	texture_atlas.region.position.x = 5 + 31 * frame

func time_loop():
	if frame < 1:
		return
	timer.stop()
	time_left = starting_time
	var tween = create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(self, ^"position", get_viewport_rect().size/2 - texture_atlas.region.size/2, 0.2)
	tween.parallel().tween_property(self, ^"scale", Vector2.ONE * 4, 0.2)
	tween.tween_interval(.2)
	tween.tween_property(self, ^"frame", 0, 0.6)
	tween.tween_interval(.2)
	tween.tween_property(self, ^"position", starting_position, 0.2)
	tween.parallel().tween_property(self, ^"scale", Vector2.ONE, 0.2)
	await tween.finished
	timer.start()
