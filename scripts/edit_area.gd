extends Node2D

@onready var edit_menu = $edit_menu
signal player_entered(body)
signal player_exited(body)

func _ready():
	edit_menu.hide()

# is player in bounds?
func _on_area_2d_body_entered(body):
	player_entered.emit(body)

# is player out of bounds?
func _on_area_2d_body_exited(body):
	player_exited.emit(body)
