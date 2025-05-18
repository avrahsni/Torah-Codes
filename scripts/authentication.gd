extends Control

const firebaseConfig = {
	"apiKey": "AIzaSyCcw42JiG-pgOv7qZ5O4v3bH4SZ_YpXsaw",
	"authDomain": "inventory-dashboard-444da.firebaseapp.com",
	"databaseURL": "https://inventory-dashboard-444da-default-rtdb.firebaseio.com",
	"projectId": "inventory-dashboard-444da",
	"storageBucket": "inventory-dashboard-444da.appspot.com",
	"messagingSenderId": "117677976767",
	"appId": "1:117677976767:web:073f271ddc4c7ae1606a0a",
	"measurementId": "G-YLQR15QC9P"
}

@onready var email_line_edit := $VBoxContainer/emailLineEdit
@onready var password_line_edit := $VBoxContainer/passwordLineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	Firebase.setup_modules(firebaseConfig)
	
	Firebase.Auth.login_succeeded.connect(on_login_successful)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.signup_succeeded.connect(on_signup_successful)
	Firebase.Auth.signup_failed.connect(on_signup_failed)
	
	if Firebase.Auth.check_auth_file():
		$VBoxContainer/stateLabel.text = "Logged In Successfully"
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_login_button_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
			var email = email_line_edit.text
			var password = password_line_edit.text
			Firebase.Auth.login_with_email_and_password(email, password)
			$VBoxContainer/stateLabel.text = "Loggin In..."
			pass
	pass # Replace with function body.


func _on_signup_button_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
			var email = email_line_edit.text
			var password = password_line_edit.text
			Firebase.Auth.signup_with_email_and_password(email, password)
			$VBoxContainer/stateLabel.text = "Signing Up..."
			pass
	pass # Replace with function body.

func on_login_successful(auth):
	print(auth)
	$VBoxContainer/stateLabel.text = "Logged In Successfully"
	Firebase.Auth.save_auth(auth)
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	pass

func on_login_failed(error_code, message):
	print("Error Code: " + str(error_code))
	print("Message: " + str(message))
	$VBoxContainer/stateLabel.text = "Login Failed.  Error: %s" %message
	pass

func on_signup_successful(auth):
	print(auth)
	$VBoxContainer/stateLabel.text = "Signed Up Successfully"
	Firebase.Auth.save_auth(auth)
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	pass

func on_signup_failed(error_code, message):
	print("Error Code: " + str(error_code))
	print("Message: " + str(message))
	$VBoxContainer/stateLabel.text = "Sign Up Failed.  Error: %s" %message
	pass


func _on_signup_pressed():
	var email = email_line_edit.text
	var password = password_line_edit.text
	Firebase.Auth.signup_with_email_and_password(email, password)
	$VBoxContainer/stateLabel.text = "Signing Up..."
	pass # Replace with function body.


func _on_login_pressed():
	var email = email_line_edit.text
	var password = password_line_edit.text
	Firebase.Auth.login_with_email_and_password(email, password)
	$VBoxContainer/stateLabel.text = "Loggin In..."
	pass # Replace with function body.
