extends Node

var Globals

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals = get_node("/root/Globals")
	self.text = "Carregando..."
	self.position = Vector2(Globals.screen_width, Globals.screen_height)
	self.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
