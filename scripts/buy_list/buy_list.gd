extends ItemList

var Globals
var prices = []

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals = get_node("/root/Globals")
	self.set_position(Vector2(50, 131))
	self.set_size(Vector2(1000, 600))
	#self.connect("item_added", _on_item_added)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.buy_list_needs_update:
		remove_all_items()
		add_list()
		Globals.buy_list_needs_update = false
	pass

func remove_all_items():
	while self.item_count > 0:
		self.remove_item(0)
		
func add_list():
	for item in Globals.buy_list:
		var item_string = "%s (R$ %.2f/kg) - R$ %.2f" % [item[0], item[2], item[1] * item[2]]
		prices.append(item[1] * item[2])
		self.add_item(item_string)

func _on_cancel_button_pressed():
	if self.is_anything_selected():
		Globals.buy_list.remove_at(self.get_selected_items()[0])
		self.remove_item(self.get_selected_items()[0])
	pass # Replace with function body.


func _on_finish_button_pressed():
	var receipt = FileAccess.open("receipt.txt", FileAccess.WRITE)
	var i = 0
	while i < self.item_count:
		receipt.store_string(self.get_item_text(i) + '\n')
		i += 1
	Globals.buy_list.clear()
	remove_all_items()
	pass # Replace with function body.
