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


@onready var timer = $Timer

var prev_drawn_frames := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Firebase.setup_modules(firebaseConfig)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#$ColorRect.color = Global.coral
	#$Label.text = "FPS: " + str(Engine.get_frames_per_second())
	#print(Engine.get_frames_drawn())
	#menu_button.position.x = Menu.sprite.position.x # + Menu.size.x
	pass



func _on_timer_timeout():
	print(Engine.get_frames_drawn() - prev_drawn_frames)
	print("Average FPS: " + str(float(Engine.get_frames_drawn() - prev_drawn_frames) / 5))
	prev_drawn_frames = Engine.get_frames_drawn()
	pass # Replace with function body.
