extends Node

# editing area variables
@onready var edit_area = $edit_area
@onready var edit_menu = $edit_menu
var editing = false
var in_edit_bounds = false

var levels = {0:preload("res://scenes/levels/title_screen_level.tscn").instantiate(),
1:preload("res://scenes/levels/level_one.tscn").instantiate(),
2:preload("res://scenes/levels/level_one_pt_two.tscn").instantiate(),
3:preload("res://scenes/levels/level_two.tscn").instantiate(),
4:preload("res://scenes/levels/level_three.tscn").instantiate(),
5:preload("res://scenes/levels/level_four.tscn").instantiate()}
var level_spawns = {0:Vector2(100,500),
1:Vector2(100,500),
2:Vector2(150,200),
3:Vector2(1200,600),
4:Vector2(200,500),
5:Vector2(200,600)}
var level_exits = {0:Vector2(1200,500),
1:Vector2(1200,200),
2:Vector2(1000,225),
3:Vector2(50,90),
4:Vector2(500, 90),
5:Vector2(1100,200)}

var level = 0

#var game = preload("res://scenes/levels/level_one.tscn").instantiate()


# Called when the node enters the scene tree for the first time.
func _ready():
	#$Player.position = level_spawns["LevelOne"]
	#$Player.spawn_position = level_spawns["LevelOne"]
	change_to_level(level)
	

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

func change_to_level(new_level:int):
	print("changing to level " + str(new_level))
	level = new_level
	$Exit.monitorable = false
	$Exit.monitoring = false
	
	for i in get_children():
		if i.name.to_lower().contains("level"):
			remove_child(i)
	add_child(levels[new_level])
	move_child(levels[new_level], 0)
	$Player.position = level_spawns[new_level]
	$Player.spawn_position = level_spawns[new_level]
	$edit_area.position = level_spawns[new_level]
	
	$Exit.position = level_exits[new_level]
	$Exit.monitorable = true
	$Exit.monitoring = true
	

# is player in bounds?
func _on_edit_area_player_entered(_body):
	in_edit_bounds = true

# is player out of bounds?
func _on_edit_area_player_exited(_body):
	in_edit_bounds = false


func _on_level_exit_body_entered(body):
	print(body)
	change_to_level(level + 1)
