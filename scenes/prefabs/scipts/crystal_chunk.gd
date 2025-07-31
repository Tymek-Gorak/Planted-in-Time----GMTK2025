extends CharacterBody2D

const THROW_SPEED := 170

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	GameManager.time_loop_signal.connect(queue_free)

func _physics_process(delta: float) -> void:
	sprite.play("spin")
	velocity = Vector2.from_angle(rotation) * THROW_SPEED
	move_and_slide()
	for i : int in get_slide_collision_count():
		var collision = get_slide_collision(i).get_collider()
		if collision is TimeLooper or collision is PushBox:
			collision.cancel_loop = true
		queue_free()
