extends CharacterBody2D

class_name Player

signal player_died

@onready var animation_player:AnimationPlayer = $AnimationPlayer
@onready var sprite:Sprite2D = $Icon

var speed = 250
var gravity = 30
var jump = -500

var dead = false

var is_on_jump_orb = false

func _physics_process(_delta: float) -> void:
	
	if not is_on_floor():
		velocity.y += gravity
		sprite.rotation += .09
	else:
		sprite.rotation = snapped(sprite.rotation, deg_to_rad(90))

	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = jump
		
	if Input.is_action_just_pressed("ui_accept") and is_on_jump_orb:
		velocity.y = jump
		
	if is_on_wall(): die()
	
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
	velocity = Vector2(0,0)
	await get_tree().physics_frame
	await get_tree().physics_frame
	dead = false
