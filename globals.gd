extends Control

#screen
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")
var screen_height = ProjectSettings.get_setting("display/window/size/viewport_height")

#colors
const default_button_color = Color("3fa0eb")
const default_header_color = Color("2081c6")

var buy_list = []
var buy_list_needs_update = false
var total_price = 0

func _ready():
	OS.create_process("python3", ["scripts/ai/ai.py"])
	pass

#events
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		FileAccess.open("scripts/ai/request_python_close", FileAccess.WRITE).close()
		get_tree().quit()
