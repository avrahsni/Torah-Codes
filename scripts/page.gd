extends Control

@export var page_name: String

# Called when the node enters the scene tree for the first time.
func _ready():
	var rand = randi()
	$Panel/Label.text = page_name + " Page"
	var stylebox := StyleBoxFlat.new()
	stylebox = $Panel.get_theme_stylebox("panel")
	stylebox.bg_color = Global.olivine if rand % 3 == 0 else Global.coral if rand % 3 ==1 else Global.celadon
	$Panel.add_theme_stylebox_override("panel", stylebox)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_elements():
	self.visible = Global.selected_page.label.to_lower() == page_name
