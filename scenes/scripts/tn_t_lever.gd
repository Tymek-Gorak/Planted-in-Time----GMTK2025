extends TimeLooper
class_name TntSwitch

signal lever_press()

@export var normal_sprite : Texture
@export var pressed_sprite : Texture


var selected : bool:
	set(value):
		selected = value
		if sprite_2d.texture == pressed_sprite: return
		outline_container.visible = selected

const OUTLINE_SHADER = preload("res://assets/shaders/OutlineShader.tres")

@onready var outline_container := Node2D.new()
@onready var sprite_2d: Sprite2D = %Sprite2D

func _ready() -> void:
	super._ready()
	_generate_outline()

func _generate_outline():
	#outline container setup
	add_child(outline_container)
	outline_container.show_behind_parent = true
	outline_container.visible = false
	outline_container.name = "outline_container"

	for x in range(-1, 2, 1):
		for y in range(-1, 2, 1):
			#copy the original sprite
			var outline_side = Sprite2D.new()
			outline_container.add_child(outline_side)
			outline_side.texture = sprite_2d.texture
			outline_side.scale = sprite_2d.scale
			outline_side.region_enabled = sprite_2d.region_enabled
			outline_side.region_rect = sprite_2d.region_rect

			#make it an outline
			outline_side.name = "outline_side"
			outline_side.material = OUTLINE_SHADER
			outline_side.position += Vector2(x, y) * 1

func time_loop():
	if cancel_loop:
		#wait for the rock and tnt to do their time_loop()
		await get_tree().create_timer(0.1).timeout
		interact()
		cancel_loop = false
		return
	sprite_2d.texture = normal_sprite

func interact():
	selected = false
	sprite_2d.texture = pressed_sprite
	lever_press.emit()
