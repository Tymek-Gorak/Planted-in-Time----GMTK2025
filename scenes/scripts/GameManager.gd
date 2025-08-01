extends Node


signal time_loop_signal()

@onready var transition_manager : TransitionManagerScript = TransitionManager

func time_loop():
	time_loop_signal.emit()
	#enter transition
	transition_manager.black_middle_fade_out()
	await transition_manager.transition_finished

	var player : Player = get_tree().get_first_node_in_group("player")
	if is_instance_valid(player):
		player.time_loop()
	for node in get_tree().get_nodes_in_group("time_loopables"):
		if not is_instance_valid(node): continue
		if node.has_method("time_loop"):
			node.time_loop()
	await get_tree().create_timer(.3).timeout
	#exit transition
	transition_manager.black_middle_fade_in()
