extends Node

var level_spawns = {"LevelOne":Vector2(1000,500)}

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.position = level_spawns["LevelOne"]
	$Player.spawn_position = level_spawns["LevelOne"]
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
