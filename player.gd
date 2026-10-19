extends CharacterBody2D

class_name Player

signal player_died

@onready var animation_player:AnimationPlayer = $AnimationPlayer
@onready var sprite:Sprite2D = $Icon

var speed = 250
var gravity = 30
var gravity_state = 1
var jump = -500

var dead = false

var is_on_jump_orb = false
var is_on_gravity_orb = false
var is_on_ground = false

func _physics_process(_delta: float) -> void:
	
	if gravity_state == 1:
		is_on_ground = true if is_on_floor() else false
		if is_on_ceiling(): die()
	elif gravity_state == -1:
		is_on_ground = true if is_on_ceiling() else false
		if is_on_floor(): die()
		
	if is_on_wall(): die()
	
	if not is_on_ground:
		print("not on ground")
		velocity.y += gravity * gravity_state
		sprite.rotation += .09 * gravity_state
	else:
		sprite.rotation = snapped(sprite.rotation, deg_to_rad(90))

	if Input.is_action_pressed("ui_accept") and is_on_ground && velocity.y == 0:
		velocity.y = jump * gravity_state
		
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_jump_orb:
			velocity.y = jump * gravity_state
		elif is_on_gravity_orb:
			velocity.y = jump * gravity_state
			gravity_state *= -1

	velocity.x = speed
	move_and_slide()
	
	
func die():
	if dead: return
	dead = true
	animation_player.play("die")
	set_physics_process(false)
	await get_tree().create_timer(1).timeout
	emit_signal("player_died")
	
	
func reset_to_position(pos: Vector2):
	animation_player.play("RESET")
	set_physics_process(true)
	global_position = pos
	gravity_state = 1
	is_on_jump_orb = false
	is_on_gravity_orb = false
	is_on_ground = false
	velocity = Vector2(0,0)
	await get_tree().physics_frame
	await get_tree().physics_frame
	dead = false
