extends Button

var Globals

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals = get_node("/root/Globals")
	self.anchor_top = 0.5
	self.anchor_bottom = 0.5
	self.anchor_left = 0.5
	self.anchor_right = 0.5
	self.text = "Cancelar"
	var width = self.get_rect().size.x
	var height = self.get_rect().size.y
	self.custom_minimum_size = Vector2(300, 150)
	self.set_position(Vector2(0.775 * Globals.screen_width, 0.571 * Globals.screen_height))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
