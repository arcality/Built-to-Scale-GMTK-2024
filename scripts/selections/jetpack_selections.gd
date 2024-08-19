extends Control

# mutually exclusive button group
@export var jetpack_group: ButtonGroup
signal toggled(toggled_on: bool)
signal jetpack_selected(jetpack_type: Button)

func _ready():
	# running the button_pressed() function whenever a button is pressed
	for i in jetpack_group.get_buttons():
		i.toggled.connect(button_toggled)
	print(jetpack_group.get_buttons())

# send signal that button has been toggled up
func button_toggled(toggled_on: bool):
	#if jetpack_group.get_pressed_button() != null && toggled_on:
		#print(jetpack_group.get_pressed_button().name)
	#elif jetpack_group.get_pressed_button() == null:
		#print(jetpack_group.get_pressed_button())
	
	# emit which ability is selected when it is on
	if toggled_on:
		jetpack_selected.emit(jetpack_group.get_pressed_button())
