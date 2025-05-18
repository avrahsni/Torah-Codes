extends Node

const asparagus = Color("678d58")
const celadon = Color("74d3ae")
const champagne = Color("f6e7cb")
const coral = Color("dd9787")
const olivine = Color("a6c48a")

const beige = Color("f5EEDC")
const blue = Color("27548A")
const navy = Color("183B4E")
const yellow = Color("DDA853")

var selected_page
var pages_info: Array
var app_bar

var logged_in_user: FirebaseUserData
signal logged_in

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

#@onready var menu = preload("res://scenes/menu.tscn").instantiate()


func _ready():
	
	DisplayServer.window_set_min_size(Vector2i(768, 432))
	#OS.set
	print(OS.low_processor_usage_mode)
	OS.low_processor_usage_mode = true
	print(OS.low_processor_usage_mode)
	#self.add_child(menu)
	pass


func _process(delta):
	#print(OS.low_processor_usage_mode)
	pass
