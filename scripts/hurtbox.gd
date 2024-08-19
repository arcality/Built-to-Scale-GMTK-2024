extends Area2D



func _on_body_entered(body):
	print(body)
	$"../FiniteStateMachine".force_change_state("death")
