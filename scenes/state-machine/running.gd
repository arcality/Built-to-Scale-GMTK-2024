extends State

var player : CharacterBody2D

var speed = 10000

func Enter():
	# stores the parent player node as "player"
	player = owner

func Exit():
	pass

func Update(delta:float):
	# directly changes horizontal velocity depending on left/right directional keys
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	player.velocity.x = horizontal_direction * speed * delta
	
	if horizontal_direction == 0:
		state_transition.emit(self, "idle")
		print("transition to idle")
