extends Node

# editing area variables
@onready var edit_area = $edit_area
@onready var edit_menu = $edit_menu
var editing = false
var in_edit_bounds = false

func _process(_delta):
		# if edit key is pressed while in this area, enter editing menu
	if Input.is_action_just_pressed("edit") and in_edit_bounds:
		editMenu()

func editMenu():
	if editing:
		edit_menu.hide()
		Engine.time_scale = 1
	else:
		edit_menu.show()
		Engine.time_scale = 0
	
	editing = !editing


# is player in bounds?
func _on_edit_area_player_entered(_body):
	in_edit_bounds = true

# is player out of bounds?
func _on_edit_area_player_exited(_body):
	in_edit_bounds = false
