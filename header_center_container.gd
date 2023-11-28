extends CenterContainer
var Globals

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals = get_node("/root/Globals")
	self.set_position(Vector2(Globals.screen_width / 2, Globals.screen_height / 12))
	self.use_top_left = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
