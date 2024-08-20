extends State

var player : Player

func Enter():
	player = owner


func Update(_delta:float):
	player.position = player.spawn_position
	state_transition.emit(self, "idle")


func Exit():
	pass
	
