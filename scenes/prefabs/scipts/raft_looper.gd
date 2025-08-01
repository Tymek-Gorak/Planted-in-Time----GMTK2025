extends TimeLooper

@onready var raft: Raft = owner

func time_loop():
	super.time_loop()
	raft.time_loop()
