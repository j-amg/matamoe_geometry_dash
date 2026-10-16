extends Node2D

@onready var player:CharacterBody2D = $Player
@onready var spawn_position:Marker2D = $SpawnPosition
@onready var finish_line:Area2D = $FinishLine
@onready var progress_bar:ProgressBar = $CanvasLayer/MarginContainer/ProgressBar
@onready var complete_level_screen:PanelContainer = $CanvasLayer/CompleteLevelScreen


func _ready() -> void:
	player.player_died.connect(on_player_died)
	start_level()
	
func _process(_delta: float) -> void:
	progress_bar.value = ((player.global_position.x - spawn_position.global_position.x) / finish_line.global_position.x) * 100
	if progress_bar.value >= 100: complete_level()
	
func on_player_died():
	start_level()

func start_level():
	complete_level_screen.hide()
	player.reset_to_position(spawn_position.global_position)
	
func complete_level():
	player.set_physics_process(false)
	complete_level_screen.show()


func _on_restart_button_pressed() -> void:
	print("pressed")
	start_level()
