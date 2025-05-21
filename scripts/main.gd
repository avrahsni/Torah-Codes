extends Control




@onready var timer = $Timer

var prev_drawn_frames := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_timer_timeout():
	print(Engine.get_frames_drawn() - prev_drawn_frames)
	print("Average FPS: " + str(float(Engine.get_frames_drawn() - prev_drawn_frames) / 5))
	prev_drawn_frames = Engine.get_frames_drawn()
	pass # Replace with function body.
