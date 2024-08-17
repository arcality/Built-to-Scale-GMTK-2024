extends Node
class_name FiniteStateMachine

var states : Dictionary = {}
@export var initial_state: State
var current_state : State

func _ready():
	# automatically adds each child to dictionary and connects signals via code
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child # add to dictionary
			child.state_transition.connect(change_state) # connect signal to function "change_state"
			
	# if an initial state has been set, then it is entered
	if initial_state:
		initial_state.Enter()
		current_state = initial_state


func change_state(old_state : State, new_state_name : String):
	# checks if old_state is in fact the old state
	if old_state != current_state:
		print("Invalid change_state trying from: " + old_state.name + " but currently in: " 
		+ current_state.name)
		return
	
	# checks if the new_state exists in the dictionary
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		print("New state is empty")
		return
	
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
	
	# keeps track of current state (sets it to the newly transitioned-to state)
	current_state = new_state

# continuously calls current state's Update() function
func _process(delta):
	if current_state:
		current_state.Update(delta)
