extends Node

enum states
{
	hunting,
	afraid,
	dead
}

var player
var is_colliding_with_player: bool
var is_in_ghost_home: bool

var current_state: states = states.hunting


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match current_state:
		states.hunting:
			if player.ate_energizer: current_state = states.afraid
			# move towards player
			
		states.afraid:
			if player.energizer_timer <= 0: current_state = states.hunting
			if is_colliding_with_player: current_state = states.dead
			# move away from player
			
		states.dead:
			if is_in_ghost_home: current_state = states.hunting
			# move toward ghost home
