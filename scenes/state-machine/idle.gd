extends State



func Enter():
	pass

func Exit():
	pass

func Update(delta):
	if Input.get_axis("move_left", "move_right") != 0:
		state_transition.emit(self, "running")
		print("transition to running")
	# makes sure that this was not triggered by stopping the spin
	if Input.is_action_pressed("jump"):
		state_transition.emit(self, "jumping")
	


