extends Control
var Globals

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals = get_node("/root/Globals")
	self.set_size(Vector2(Globals.screen_width, Globals.screen_height / 6))
	self.set_position(Vector2(0, 0))
	self.color = Globals.default_header_color
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
