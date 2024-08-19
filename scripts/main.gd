extends Node

# editing area variables
@onready var edit_area = $edit_area
@onready var edit_menu = $edit_menu
var editing = false
var in_edit_bounds = false

var levels = {1:preload("res://scenes/levels/level_one.tscn").instantiate()}
var level_spawns = {1:Vector2(1200,600)}

#var game = preload("res://scenes/levels/level_one.tscn").instantiate()


# Called when the node enters the scene tree for the first time.
func _ready():
	#$Player.position = level_spawns["LevelOne"]
	#$Player.spawn_position = level_spawns["LevelOne"]
	change_to_level(1)
	

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

func change_to_level(level:int):
	$Player.position = level_spawns[level]
	$Player.spawn_position = level_spawns[level]
	$edit_area.position = level_spawns[level]
	add_child(levels[level])
	move_child(levels[level], 0)
	

# is player in bounds?
func _on_edit_area_player_entered(_body):
	in_edit_bounds = true

# is player out of bounds?
func _on_edit_area_player_exited(_body):
	in_edit_bounds = false
