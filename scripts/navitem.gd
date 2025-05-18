extends Control

@export var active := false
@onready var panel: Panel = $MarginContainer/Panel
@onready var anim = $AnimationPlayer

@export var icon: String
@export var label: String

var hovering := false

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer2/HBoxContainer/MaterialIcon.icon_name = icon
	$MarginContainer2/HBoxContainer/Label.text = label
	if label == "Home":
		Global.selected_page = self
	update_elements()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

func set_active():
	active = true
	update_elements()

func set_deactive():
	active = false
	update_elements()

func update_elements():
	var stylebox := StyleBoxFlat.new()
	stylebox = panel.get_theme_stylebox("panel")
	#stylebox.bg_color = Global.olivine if hovering else "#00000000" if !active else Global.coral
	stylebox.bg_color = "#00000000" if !active else Global.navy
	panel.add_theme_stylebox_override("panel", stylebox)
	if Global.app_bar != null: Global.app_bar.update_elements()
	var pages = get_tree().get_nodes_in_group("pages")
	for page in pages:
		page.update_elements()
	pass

func _on_mouse_entered():
	hovering = true
	if !active:
		var stylebox := StyleBoxFlat.new()
		stylebox = panel.get_theme_stylebox("panel")
		stylebox.bg_color = Global.yellow
		self.panel.add_theme_stylebox_override("panel", stylebox)
	pass # Replace with function body.


func _on_mouse_exited():
	hovering = false
	var stylebox := StyleBoxFlat.new()
	stylebox = panel.get_theme_stylebox("panel")
	stylebox.bg_color = "#00000000" if !active else Global.navy
	self.panel.add_theme_stylebox_override("panel", stylebox)
	pass # Replace with function body.


func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
			var navitems = get_tree().get_nodes_in_group("navitems")
			for item in navitems:
				item.set_deactive()
			Global.selected_page = self
			set_active()
			
	pass # Replace with function body.
