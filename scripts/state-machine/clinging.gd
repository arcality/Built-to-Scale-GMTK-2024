extends State

var player : Player

# doesn't work yet

func Enter():
	player = owner
	player.special_jump_used = false
	player.gravity = 0
	player.velocity.y = 0
	

func Exit():
	player.gravity = 2000

func Update(_delta:float):
	pass
	
