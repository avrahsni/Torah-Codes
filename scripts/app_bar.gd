extends Control

@onready var hbox := $HBoxContainer
@onready var menu_button := $Button

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.app_bar = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#var mid = (size.x - menu_button.size.x) / (hbox.get_child_count() + 1)
	#hbox.add_theme_constant_override("separation", mid)
	#menu_button.position.x = Menu.position.x + Menu.size.x
	pass

func update_elements():
	$HBoxContainer/Label.text = Global.selected_page.label


func _on_button_pressed():
	print("Menu Button Pressed")
	Global.menu.position.x += 256 if Global.menu.position.x < 256 else -256
	
	pass # Replace with function body.
