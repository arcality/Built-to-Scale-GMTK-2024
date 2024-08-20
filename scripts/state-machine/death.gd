extends State

var player : Player

func Enter():
	player = owner
	player.velocity.x = 0
	player.velocity.y = 0
	player.gravity = 0
	$Timer.start()

func Update(_delta:float):
	pass


func Exit():
	player.position = player.spawn_position
	player.gravity = 2000.0
	


func _on_timer_timeout():
	state_transition.emit(self, "idle")
