extends Node2D

signal player_entered(body)
signal player_exited(body)

# is player in bounds?
func _on_area_2d_body_entered(body):
	player_entered.emit(body)

# is player out of bounds?
func _on_area_2d_body_exited(body):
	player_exited.emit(body)
