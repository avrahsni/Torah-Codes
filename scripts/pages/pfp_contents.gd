extends Control

@onready var username_label := $MarginContainer/VBoxContainer/Name
@onready var email_label := $MarginContainer/VBoxContainer/email
@onready var status_label := $MarginContainer/VBoxContainer/status
@onready var signout_button := $MarginContainer/VBoxContainer/Button

var user_name: String
var email: String

# Called when the node enters the scene tree for the first time.
func _ready():
	Firebase.Auth.get_user_data()
	#print(FirebaseAuth.userdata_received(userdata))
	#FirebaseUserData.new(FirebaseAuth.RESPONSE_USERDATA)
	#Firebase.Auth.get_user_data()
	await Global.logged_in
	email = Global.logged_in_user.email
	email_label.text = "Email: " + email
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	status_label.text = "Loggin Out..."
	Firebase.Auth.logout()
	#await Firebase.Auth.logged_out
	get_tree().change_scene_to_file("res://scenes/authentication.tscn")
	pass # Replace with function body.
