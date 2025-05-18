@tool
extends EditorPlugin


func _enter_tree():
	# Initialization of the plugin goes here.
	add_custom_type("Page", "Control", preload("res://addons/Page_plugin/page.gd"), preload("res://icon.svg"))
	pass


func _exit_tree():
	# Clean-up of the plugin goes here.
	remove_custom_type("Page")
	pass
