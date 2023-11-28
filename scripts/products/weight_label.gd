extends Label

var Globals
var Serial

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals = get_node("/root/Globals")
	Serial = get_node("/root/Serial")
	self.z_as_relative = 1
	self.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	self.set_position(Vector2(Globals.screen_width / 2, Globals.screen_height / 2))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = "%s kg" % Serial.weight
	pass
