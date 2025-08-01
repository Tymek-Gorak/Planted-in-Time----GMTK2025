extends TimeLooper

@export var normal_sprite : Texture
@export var blown_up_sprite : Texture

@onready var sprite_2d: Sprite2D = $Sprite2D

func time_loop():
	super.time_loop()
	sprite_2d.texture = normal_sprite
	set_collision_layer_value(2, true)
	set_collision_layer_value(3, true)

func explode():
	sprite_2d.texture = blown_up_sprite
	set_collision_layer_value(2, false)
	set_collision_layer_value(3, false)
