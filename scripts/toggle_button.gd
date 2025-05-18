extends Control

@onready var anim_player = $"../../../AnimationPlayer"
@export var min_size := 70

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_gui_input(event):
	if event is InputEventMouseButton:
		var mouse_event: InputEventMouseButton = event
		if mouse_event.pressed: #.button_index == 1:
			var panel_min = $"../../..".custom_minimum_size.x
			var navitems = get_tree().get_nodes_in_group("navitems")
			if panel_min < 200:
				anim_player.play("sidebar_anim")
				for item in navitems:
					item.anim.play("sidebar")
			else:
				anim_player.play_backwards("sidebar_anim")
				for item in navitems:
					item.anim.play_backwards("sidebar")
	
	
	pass # Replace with function body.
