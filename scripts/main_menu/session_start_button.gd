extends Button
var Globals

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals = get_node("/root/Globals")
	self.text = "Iniciar sessão"
	self.anchor_left = 0.5
	self.anchor_right = 0.5
	self.anchor_top = 0.5
	self.anchor_bottom = 0.5
	var width = self.get_rect().size.x
	var height = self.get_rect().size.y
	self.set_position(Vector2((Globals.screen_width - width) / 2, (Globals.screen_height - height) / 2))
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	return


func _on_pressed():
	get_tree().change_scene_to_file("res://scenes/BuyList.tscn")
