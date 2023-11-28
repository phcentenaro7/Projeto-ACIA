extends CenterContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_position(Vector2(0.761 * Globals.screen_width, 0.75 * Globals.screen_height))
	self.use_top_left = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
