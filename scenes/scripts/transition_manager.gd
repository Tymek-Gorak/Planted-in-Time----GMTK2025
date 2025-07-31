extends CanvasLayer
class_name TransitionManagerScript

signal transition_finished()

@onready var animation_player: AnimationPlayer = %AnimationPlayer

func black_middle_fade_out():
	animation_player.play("black_screen_transition")
	await animation_player.animation_finished
	transition_finished.emit()

func black_middle_fade_in():
	animation_player.play_backwards("black_screen_transition")
	await animation_player.animation_finished
	transition_finished.emit()
