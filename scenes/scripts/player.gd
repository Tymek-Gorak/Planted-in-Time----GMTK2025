extends CharacterBody2D
class_name Player


@export var MAX_SPEED := 250
@export var ACCELERATION := 1200
@export var PUSH_FORCE := 15
@export var THROWING_CRYSTAL : PackedScene

var ammo = 3
var move_direction := Vector2(0,0)
var throw_direction := Vector2(0,1)

@onready var starting_position := position
@onready var animation_player := %AnimationPlayer
@onready var sprite_2d := %Sprite2D

func _ready():
	animation_player.play("idle_forwards")

func _physics_process(delta):
	#region animations
	if not velocity.is_zero_approx():
		if move_direction.y < 0:
			animation_player.play("walk_backwards")
		elif move_direction.y > 0:
			animation_player.play("walk_forwards")
		if move_direction.x != 0:
			if animation_player.current_animation == "idle_backwards": animation_player.play("walk_backwards")
			if animation_player.current_animation == "idle_forward": animation_player.play("walk_forwards")
	else:
		if animation_player.current_animation == "walk_backwards": animation_player.play("idle_backwards")
		if animation_player.current_animation == "walk_forwards": animation_player.play("idle_forwards")
	#endregion

	if velocity.x > 0:
		sprite_2d.flip_h = true
	elif velocity.x < 0:
		sprite_2d.flip_h = false

	velocity = velocity.move_toward(move_direction * MAX_SPEED, ACCELERATION *delta)

	move_and_slide()

	#pick up and collide with potions
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i).get_collider()
		if collision is PushBox:
			collision.velocity = collision.position - position
		if collision is not RigidBody2D:
			continue
		collision.apply_central_impulse(-get_slide_collision(i).get_normal() * PUSH_FORCE)

func _unhandled_input(event: InputEvent):
	move_direction = Input.get_vector("left", "right", "up", "down")
	if not move_direction.is_zero_approx(): throw_direction = move_direction
	if event.is_action_pressed("throw"):
		throw()
	if event.is_action_pressed("interact"):
		interact()
	if event.is_action_pressed("time_loop"):
		GameManager.time_loop()

func time_loop():
	animation_player.play("time_loop")

func throw():
	if ammo <= 0:
		return
	ammo -= 1
	var crystal : CharacterBody2D = THROWING_CRYSTAL.instantiate()
	get_parent().add_child(crystal)
	crystal.position = position
	crystal.rotation = throw_direction.angle()


func interact():
	#TODO
	pass
