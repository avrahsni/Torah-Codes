extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Smoothly interpolate the current position to the target position
	position = position.lerp(target_position, smooth_factor)
	pass


# Controls how much the camera moves on every turn of the scroll wheel.
@export var scroll_speed := 100.0
# Smoothing factor for smooth movement.
@export var smooth_factor := 0.9
# The camera's target position.
var target_position := Vector2.ZERO

# Update the camera’s position using the input actions defined earlier.
func _unhandled_input(event):
	check_vert(event)
	#check_hor(event)
	
	

func check_vert(event):
	if event is InputEventPanGesture:
		#print(event.delta)
		if event.delta.y > 0:
			#Scroll Down
			if target_position.y < limit_bottom:
				target_position.y += scroll_speed
		if event.delta.y < 0:
			#Scroll Up
			if target_position.y > limit_top:
				target_position.y -= scroll_speed
	
	if event.is_action("scroll_up") or event.is_action("ui_text_scroll_up.macos") or event.is_action("ui_text_scroll_up"):
		target_position.y -= scroll_speed
	if event.is_action("scroll_down") or event.is_action("ui_text_scroll_down.macos") or event.is_action("ui_text_scroll_down"):
		target_position.y += scroll_speed
		

func check_hor(event):
	if event is InputEventPanGesture:
		#print(event.delta)
		if event.delta.x > 0 and target_position.x < limit_right:
			#Scroll Right
			target_position.x += scroll_speed / 2
		if event.delta.x < 0 and target_position.x > limit_left:
			#Scroll Left
			target_position.x -= scroll_speed / 2
		
	if event.is_action("scroll_left") and target_position.x > limit_left:
		target_position.x -= scroll_speed / 2
	if event.is_action("scroll_right") and target_position.x < limit_right:
		target_position.x += scroll_speed / 2
