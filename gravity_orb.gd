extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.is_on_gravity_orb = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.is_on_gravity_orb = false
