extends Control

@onready var main = $"../"

func _ready():
	self.hide()

func _on_resume_pressed():
	main.editMenu()
