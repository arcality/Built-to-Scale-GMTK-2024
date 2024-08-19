extends State

var player : Player

var dash_speed = 3000

func Enter():
	player = owner
	player.velocity.y = 0
	player.velocity.x = dash_speed * player.facing_direction
	player.gravity = 0
	$Timer.start()
	
func Update(_delta:float):
	if player.is_on_wall():
		$Timer.stop()
		state_transition.emit(self, "falling")
		print("transition to falling")
	if player.is_on_floor():
		$Timer.stop()
		state_transition.emit(self, "idle")
		print("transition to idle")

func Exit():
	player.gravity = 2000.0


func _on_timer_timeout():
	state_transition.emit(self, "falling")
	print("transition to falling")
	print("Timer timeout")
