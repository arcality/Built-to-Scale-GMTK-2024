extends Node2D

@onready var edit_menu = $edit_menu
var editing = false
var in_bounds = false

func _ready():
	edit_menu.hide()

func _process(_delta):
	# if edit key is pressed while in this area, enter editing menu
	if Input.is_action_just_pressed("edit") and in_bounds:
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
func _on_area_2d_body_entered(body):
	in_bounds = true

# is player out of bounds?
func _on_area_2d_body_exited(body):
	in_bounds = false
