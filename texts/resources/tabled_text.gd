extends Resource
class_name TabledText

@export var text:= ""
@export var rows:= []
@export var columns:= []
@export var colnum:= 0


func set_table(text: String, colnum: int):
	
	var count = 0
	
	for i in colnum:
		columns.append([])
	
	for c in text:
		columns[count].append(c)
		count += 1
		if count >= colnum:
			count = 0
	
	for i in columns:
		print("Column" + str(columns.find(i)) + "\n")
	
	
	pass

func save_to_file():
	
	#var save_file = FileAccess.open("user://bereshit_table.txt", FileAccess.WRITE)
	var result = ResourceSaver.save(self, "user://bereshit_resource.tres",)
	assert(result == OK)
	#save_file.store_string(text_table)
	
	pass
