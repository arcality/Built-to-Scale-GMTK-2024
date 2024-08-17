extends State

var player : Player

func Enter():
	player = owner
	player.special_jump_used = false

func Exit():
	pass

func Update(_delta):
	if player.movement_direction() != 0:
		state_transition.emit(self, "running")
		print("transition to running")
	# makes sure that this was not triggered by stopping the spin
	if player.trying_jump() and player.is_on_floor():
		state_transition.emit(self, "jumping")
		print("transition to jumping from idle")
	


