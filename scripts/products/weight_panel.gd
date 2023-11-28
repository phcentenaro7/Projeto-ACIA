extends Panel

var Global

# Called when the node enters the scene tree for the first time.
func _ready():
	Global = get_node("/root/Globals")
	self.custom_minimum_size = Vector2(300, 300)
	self.z_as_relative = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
