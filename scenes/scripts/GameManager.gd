extends Node


signal time_loop_signal()

@onready var transition_manager : TransitionManagerScript = TransitionManager

func time_loop():
	time_loop_signal.emit()
	#enter transition
	transition_manager.black_middle_fade_out()
	await transition_manager.transition_finished

	var player : Player = get_tree().get_first_node_in_group("player")
	player.time_loop()
	for node : TimeLooper in get_tree().get_nodes_in_group("time_loopables"):
		node.time_loop()
	for node : PushBox in get_tree().get_nodes_in_group("time_loopable_boxes"):
		node.time_loop()

	#exit transition
	transition_manager.black_middle_fade_in()
