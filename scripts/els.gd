extends Control

@onready var filename_label = $MarginContainer/VBoxContainer/file

@onready var searchbutton = $MarginContainer/VBoxContainer/search/search1/Button
@onready var disp_text = $MarginContainer/VBoxContainer/Control/ScrollContainer/SubViewportContainer/SubViewport/RenderingServer
@onready var search_bar = $MarginContainer/VBoxContainer/search/search1/searchbar

@onready var row_size = $MarginContainer/VBoxContainer/search/search1/VBoxContainer/SliderContainer/row_size
@onready var row_size_label = $MarginContainer/VBoxContainer/search/search1/VBoxContainer/SliderContainer/LabelSize

@onready var igsub: CheckBox = $MarginContainer/VBoxContainer/search/search1/igSub/checkBox
@onready var mul_terms = $MarginContainer/VBoxContainer/search/search1/mulTerms

@onready var search_2 = $MarginContainer/VBoxContainer/search/search2/searchbar
@onready var search_3 = $MarginContainer/VBoxContainer/search/search2/searchbar2
@onready var search_4 = $MarginContainer/VBoxContainer/search/search2/searchbar3
@onready var search_5 = $MarginContainer/VBoxContainer/search/search2/searchbar4
@onready var mul_terms_row = $MarginContainer/VBoxContainer/search/search2

@onready var start = $MarginContainer/VBoxContainer/search/search3/start/TextEdit
@onready var end = $MarginContainer/VBoxContainer/search/search3/end/TextEdit
@onready var min_skip = $MarginContainer/VBoxContainer/search/search3/minSkip/TextEdit
@onready var max_skip = $MarginContainer/VBoxContainer/search/search3/maxSkip/TextEdit


#@onready var text_grid = $MarginContainer/VBoxContainer/Control/ScrollContainer/GridContainer


var searchtext: String
var final_to_normal = {
	'\u05DA': '\u05DB',  # Final Kaf to Kaf
	'\u05DD': '\u05DE',  # Final Mem to Mem
	'\u05DF': '\u05E0',  # Final Nun to Nun
	'\u05E3': '\u05E4',  # Final Pe to Pe
	'\u05E5': '\u05E6'   # Final Tsadi to Tsadi
}
var thread : Thread

#@export var text_table: String
#var table_size: int
#var tabled_text = TabledText.new()
#var table_contents := ""

# Called when the node enters the scene tree for the first time.
func _ready():
	thread = Thread.new()
	
	row_size_label.text = str(row_size.value)
	
	var file := FileAccess.open("res://texts/bereshit.txt", FileAccess.READ)
	filename_label.text = file.get_path().get_file()
	
	var rawtext = file.get_as_text()

	searchtext = rawtext
	#searchtext = remove_latin_characters(rawtext)
	searchtext = remove_non_hebrew(rawtext)
	disp_text.searchtext = searchtext
	disp_text.redraw()
	#searchtext = remove_non_latin_characters(searchtext)
	#searchtext = searchtext.strip_escapes()
	
	#var unwanted_chars = [".",",",":","?", " ", "-", "1", "	", "\n", "׃", " "]
	#for char in unwanted_chars:
		#searchtext = searchtext.replace(char,"")
	

#func load_file():
	#if not FileAccess.file_exists("user://bereshit_table.txt"):
		#return # Error! We don't have a save to load.
	#var save_file = FileAccess.open("user://bereshit_table.txt", FileAccess.READ)
	#text_table = save_file.get_as_text()
	#pass

func load_resource(file_name):
	if ResourceLoader.exists(file_name):
		var tbld_text = ResourceLoader.load(file_name)
		if tbld_text is TabledText: # Check that the data is valid
			return tbld_text

#func save_resource(text: String = "", colnum: int = 0):
	#
	#tabled_text.text = text
	#tabled_text.colnum = colnum
	#tabled_text.set_table(text, colnum)
	#tabled_text.save_to_file()

#func save_file():
	#var save_file = FileAccess.open("user://bereshit_table.txt", FileAccess.WRITE)
	#
	#save_file.store_string(text_table)
	##save_file.store_line(json_string)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	row_size_label.text = str(row_size.value)
	pass




#func set_table(filter:=""):
	#
	#var header = "[table={columns}, {inline_align}]"
	#header = table_contents.format({
		#"columns": int(row_size.value),
		#"inline_align": INLINE_ALIGNMENT_CENTER
	#})
	#var counter = 0
	#var section = ""
	#for char in filter:
		##var text = char
		#var cell := "[cell]{char}[/cell]"
		#table_contents += cell.format({"char": char})
		#counter += 1
		#if counter % 100000 == 0:
			#table_contents += section
			#section = ""
	#
	#section += "[/table]"
	#table_contents += section
	##text_table = table
	#disp_text.text = header + table_contents
	##disp_text.parse_bbcode(header + table_contents)
	#table_size = row_size.value
	#disp_text.custom_minimum_size.x = 21 * row_size.value

#func update_table(table:="[table={columns}, {inline_align}]", size:= 25):
	#var pre_disp_text = ""# "[fill]"
	#
	#disp_text.text = ""
	##var old_val = 11 + str(table_size).length()
	##print(old_val)
	##pre_disp_text = text_table.substr(old_val, text_table.length() - 1)
	#pre_disp_text = "[table=" + str(size) + ", 5]"
	#disp_text.custom_minimum_size.x = 21 * size
	#table_size = size
	#print(pre_disp_text.length())
	#disp_text.text = pre_disp_text + table_contents
	#disp_text.parse_bbcode(pre_disp_text + table_contents)
	#save_file()
	#var counter = 0
	#for c in tabled_text.text:
		#pre_disp_text += c + " "
		#counter += 1
		#if counter % (size) == 0:
			#
			#print(pre_disp_text.length())
			#print(size)
			#print(pre_disp_text.length() % size)
			#pre_disp_text += "\n"
	#pre_disp_text += "[/fill]"
	#disp_text.custom_minimum_size.x = 22 * size
	#disp_text.text = pre_disp_text



func remove_non_latin_characters(input: String) -> String:
	var output = ""
	for c in input:
		if is_latin_character(c):
			output += c
	return output

func remove_numbers(input: String) -> String:
	var output = ""
	# Numbers are in the range 48 to 57 in ASCII
	for c in input:
		if !(c >= '0' and c <= '9'):
			output += c
	return output

func is_latin_character(c: String) -> bool:
	# Latin characters are in the range 0000 to 007F (ASCII) and 0080 to 024F (Latin-1 Supplement and Latin Extended-A)
	# Latin letters range from U+0041 to U+005A (A-Z) and U+0061 to U+007A (a-z)
	return (c >= 'A' and c <= 'Z') or (c >= 'a' and c <= 'z')

func remove_non_hebrew(input: String) -> String:
	var output = ""
	var hebrew_range_start = 0x0590
	var hebrew_range_end = 0x05FF
	
	var nikkud_range_start = 0x0591
	var nikkud_range_end = 0x05C7
	
	for c in input:
		var scalar = c.unicode_at(0)  # Get the Unicode scalar value of the character
		var char = c
		if char in final_to_normal:
			char = final_to_normal[char]
		if (scalar >= hebrew_range_start and scalar <= hebrew_range_end) and (scalar < nikkud_range_start or scalar > nikkud_range_end):
			output += char  # Append the character if it is a Hebrew character
	
	return output

func remove_nikkud(input: String) -> String:
	var output = ""
	var nikkud_range_start = 0x0591
	var nikkud_range_end = 0x05C7
	
	
	
	for c in input:
		var scalar = c.unicode_at(0)  # Get the Unicode scalar value of the character
		if scalar < nikkud_range_start or scalar > nikkud_range_end:
			output += c  # Append the character if it is not a niqqud character
	
	return output

func detect_alphabet(text: String) -> String:
	var is_latin = true
	var is_hebrew = true
	
	for char in text:
		var unicode_value = char.unicode_at(0)
		
		# Check if the character is in the Latin alphabet (A-Z, a-z)
		if not ((unicode_value >= 65 and unicode_value <= 90) or (unicode_value >= 97 and unicode_value <= 122)):
			is_latin = false
		
		# Check if the character is in the Hebrew alphabet (א-ת)
		if not (unicode_value >= 1488 and unicode_value <= 1514):
			is_hebrew = false
	
	if is_latin:
		return "Latin"
	elif is_hebrew:
		return "Hebrew"
	else:
		return "Unknown"



func els(term := "", start := 0, end := 100000, min_skip := 1, max_skip := 1000, igsub := false, mul_terms := false):
	
	var max = searchtext.length() / term.length()
	max = max_skip + 1 if max > max_skip else max + 1
	
	var checktext: String = ""
	var start_positions = []
	var pos_arr = []
	var found = false
	var count = start
	while true:
		count = searchtext.findn(term[0], count + 1)
		if count == -1 or count >= end:
			break
		start_positions.append(count)
	
	for i in start_positions:
		
		for j in range(1, max):
			checktext = searchtext[i]
			var term_pos = 1
			var search_pos: String
			if i + (term_pos * j) < searchtext.length():
				search_pos = searchtext[i + (term_pos * j)]
			while search_pos == term[term_pos]:
				checktext += search_pos
				term_pos += 1
				if checktext == term:
					pos_arr.append(Vector3i(i, j, pos_arr.size()))
					found = true
					break
				if i + (term_pos * j) < searchtext.length():
					search_pos = searchtext[i + (term_pos * j)]
				else:
					break
				pass
			if found and igsub:
				found = false
				break
			pass
	
	
	return pos_arr
















func _on_search_button_pressed():
	#save_resource(searchtext, 25)
	#set_table(searchtext)
	#update_table(text_table, row_size.value)
	disp_text.colnum = row_size.value
	var term = search_bar.text if search_bar.text != "" else search_bar.placeholder_text
	print(detect_alphabet(term))
	term = remove_non_hebrew(term) if detect_alphabet(term) == "Hebrew" else remove_non_latin_characters(term) if detect_alphabet(term) == "Latin" else term 
	max_skip.text = max_skip.placeholder_text if max_skip.text == "" else max_skip.text
	min_skip.text = min_skip.placeholder_text if min_skip.text == "" else min_skip.text
	start.text = start.placeholder_text if start.text == "" else start.text
	end.text = end.placeholder_text if end.text == "" else end.text
	
	var start_time = Time.get_ticks_msec()
	thread.start(els.bind(term, int(start.text), int(end.text), int(min_skip.text), int(max_skip.text), igsub.button_pressed, mul_terms.button_pressed))
	var arr = thread.wait_to_finish()
	#var arr = els(term, int(start.text), int(end.text), int(min_skip.text), int(max_skip.text), igsub.button_pressed, mul_terms.button_pressed)
	var end_time = Time.get_ticks_msec()
	var worker_time: float = (end_time-start_time)/1000.0
	
	var found = "Found" if !arr.is_empty() else "Not Found"
	print("Step 1 Completed - " + found + " - " + str(worker_time) + "S")
	start_time = Time.get_ticks_msec()
	disp_text.reinterpret_els(arr, search_bar.text.length())
	end_time = Time.get_ticks_msec()
	worker_time = (end_time-start_time)/1000.0
	print("Step 2 Completed - " + str(worker_time) + "S")
	#disp_text.update()
	disp_text.redraw()
	
	
	#disp_text.parse_bbcode(text_table)
	#print(tabled_text.columns[1])
	pass # Replace with function body.


func _on_mul_terms_pressed():
	if mul_terms_row.visible:
		mul_terms_row.hide()
	else:
		mul_terms_row.show()
	
	pass # Replace with function body.

func _exit_tree():
	thread.wait_to_finish()
