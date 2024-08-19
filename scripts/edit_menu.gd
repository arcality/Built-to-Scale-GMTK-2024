extends Control

@onready var main = $"../"
signal arm_selected(arm_type: Button)
signal jetpack_selected(jetpack_type: Button)

func _ready():
	self.hide()

func _on_resume_pressed():
	main.editMenu()

# type of arm player chooses
func _on_jetpack_selections_jetpack_selected(jetpack_type):
	jetpack_selected.emit(jetpack_type)

# type of jetpack player chooses
func _on_arm_selections_arm_selected(arm_type):
	arm_selected.emit(arm_type)
