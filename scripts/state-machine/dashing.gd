extends State

var player : Player

var dash_speed = 1000

func Enter():
	player = owner
	player.velocity.x = dash_speed * player.facing_direction
	player.velocity.y = 0
	$Timer.start()
	
func Update(_delta:float):
	# generate particles or smth
	pass
	


func _on_timer_timeout():
	
	if player.movement_direction() != 0:
		state_transition.emit(self, "running")
		print("dashing to running")
	
	elif player.trying_jump() and player.is_on_floor():
		state_transition.emit(self, "jumping")
		print("transition to jumping from dashing")
	
	else:
		state_transition.emit(self, "falling")
		print("transition to falling from dashing")

