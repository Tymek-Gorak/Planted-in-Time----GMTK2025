extends Area2D
class_name FloorButton

signal pressed()
signal released()

@export var normal_sprite : Texture
@export var pressed_sprite : Texture

@onready var sprite_node: Sprite2D = %Sprite2D


func _on_body_entered(body: Node2D) -> void:
	sprite_node.texture = pressed_sprite
	pressed.emit()


func _on_body_exited(body: Node2D) -> void:
	sprite_node.texture = normal_sprite
	released.emit()
