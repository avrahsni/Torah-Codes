extends Control

@onready var username_label := $MarginContainer/VBoxContainer/Name
@onready var email_label := $MarginContainer/VBoxContainer/email
@onready var status_label := $MarginContainer/VBoxContainer/status
@onready var signout_button := $MarginContainer/VBoxContainer/Button

var user_name: String
var email: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	pass # Replace with function body.
