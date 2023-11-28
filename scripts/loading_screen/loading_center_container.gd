extends CenterContainer

var Globals
var Database
var ai_checker

# Called when the node enters the scene tree for the first time.
func _ready():	
	Globals = get_node("/root/Globals")
	Database = get_node("/root/Database")
	ai_checker = DirAccess.open("scripts/ai")
	self.position = Vector2(Globals.screen_width / 2, Globals.screen_height / 2)
	self.use_top_left = true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	OS.delay_msec(500)
	if ai_checker.file_exists("python_script_loaded") && Database.all_loaded:
		ai_checker.remove("python_script_loaded")
		get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
	pass
	
