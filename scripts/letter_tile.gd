extends Node2D

var letter_instance
@export var tex: Texture2D

@export var to_draw_params = {"char": "This is an example text with highlighted words", "pos": Vector2(0, 0), "width": 1080, "font_size": 16}
@export var char := "Hello World"

@onready var cam = $Camera2D

var searchtext := "This is an example text with highlighted words"
var new_colnum := 25
var colnum := 25
var items := []
var pos_arr := []
var pos_col := {}
var highlight_colors := []

var rs := RenderingServer

# Called when the node enters the scene tree for the first time.
func _ready():
	#rs = RenderingServer
	letter_instance = rs.canvas_item_create()
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func redraw():
	cam.target_position.y = 0
	
	queue_redraw()
	#update()


func reinterpret_els(arr := [], term_len:= 0):
	# x is the position it starts
	# y is the skip
	
	var count = 0
	highlight_colors.clear()
	pos_col.clear()
	pos_arr.clear()
	for i in arr:
		highlight_colors.append(generate_random_hsv_color())
		for j in term_len:
			pos_arr.append(i.x + (j * i.y) + 1)
			pos_col[i.x + (j * i.y) + 1] = arr.find(i)
		count += 1
	
	
	pass

func generate_random_hsv_color() -> Color:
	var hue = randf()  # Random hue (0.0 to 1.0)
	var saturation = randf_range(0.5, 1.0)  # Saturation between 0.5 and 1.0
	var value = randf_range(0.7, 1.0)  # Value (brightness) between 0.7 and 1.0
	return Color.from_hsv(hue, saturation, value)


#var text = "This is an example text with highlighted words"
#var keywords = ["H", "W", "o", "T", "i", "ב"]
#var highlight_color = Color(1, 0.5, 0.5, 1)  # Light red
#var normal_color = Color(1, 1, 1)  # White

func _draw():
	#if letter_instance != null:
		#rs.free_rid(letter_instance)
	
	
	if true:#new_colnum != colnum:
		colnum = new_colnum
		var start_time = Time.get_ticks_msec()
		
		var font : Font = ThemeDB.fallback_font;
		var char = to_draw_params["char"]
		var width = to_draw_params["width"]
		var size = 1760 / colnum if colnum >= 55 else 32#to_draw_params["font_size"]
		
		var count := 0
		#var rs = RenderingServer
		var pos = Vector2(0, 0)
		#if letter_instance != null:
			#rs.free_rid(letter_instance)
		#letter_instance = rs.canvas_item_create()
		#rs.canvas_item_set_draw_behind_parent(letter_instance, true)
		for c in searchtext:
			var mod = (count % colnum)
			# 1920 x 1080
			pos.x = (900 + (colnum * size / 2) - ((size * mod) + size)) #- 480
			
			pos.y = size * (((count - mod) / colnum) + 1)
			count += 1
			
			
			#rs.canvas_item_set_parent(letter_instance, get_canvas())
			#rs.canvas_item_set_z_index(letter_instance, -1)
			#
			#var color
			#if pos_arr.has(count):
				#color = highlight_colors[pos_col[count]]
			#else:
				#color = Color8(0, 0, 0, 0)
			##var color = highlight_color if keywords.has(c) else Color8(0, 0, 0, 0)
			#
			#var rect = Rect2(pos.x - (size / 4) + (size / 12), pos.y - (size * 2 / 3) - (size / 8), size, size)
			#
			#rs.canvas_item_add_texture_rect(letter_instance, rect, TextureRect.new(), false, color)
			
			draw_string(font, to_local(pos), c, HORIZONTAL_ALIGNMENT_FILL, width, size, Color.BLACK, 3, TextServer.DIRECTION_RTL)
			
		var end_time = Time.get_ticks_msec()
		var worker_time: float = (end_time-start_time)/1000.0
		print("Step 2.5 Completed - " + str(worker_time) + "S")
		cam.limit_bottom = pos.y + 256
		cam.limit_right = 1920#(colnum * 32 * 1.5) + 0
	
	update()
	





func update():
	var start_time = Time.get_ticks_msec()
	var size = 1760 / colnum if colnum >= 55 else 32#to_draw_params["font_size"]
	#var count := 0
	var rs = RenderingServer
	var pos = Vector2(0, 0)
	
	
	
	if letter_instance != null:
		rs.free_rid(letter_instance)
	letter_instance = rs.canvas_item_create()
	rs.canvas_item_set_draw_behind_parent(letter_instance, true)
	
	var color
	#if pos_arr.has(count):
		#color = highlight_colors[pos_col[count]]
	#else:
		#color = Color8(0, 0, 0, 0)
	
	
	for c in pos_arr:
		color = highlight_colors[pos_col[c]]
		var mod = ((c - 1) % colnum)
		# 1920 x 1080
		pos.x = (900 + (colnum * size / 2) - ((size * mod) + size)) + (size / 12)
		
		pos.y = size * (((c - mod) / colnum) + 1) - (size / 8)
		#count += 1
		
		
		rs.canvas_item_set_parent(letter_instance, get_canvas())
		rs.canvas_item_set_z_index(letter_instance, -1)
		
		
		#var color = highlight_color if keywords.has(c) else Color8(0, 0, 0, 0)
		
		var rect = Rect2(pos.x - (size / 4), pos.y - (size * 2 / 3), size, size)
		
		rs.canvas_item_add_texture_rect(letter_instance, rect, TextureRect.new(), false, color)
	
	var end_time = Time.get_ticks_msec()
	var worker_time: float = (end_time-start_time)/1000.0
	print("Step 3 Completed - " + str(worker_time) + "S")
	pass
