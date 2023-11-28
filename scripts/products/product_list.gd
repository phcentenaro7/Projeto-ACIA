extends ItemList

var file_mgr
var img_mgr
var top_results_file
var product_info_file
var time_elapsed
var Globals
var Database
var Serial

enum Status{
	GENERIC = 0x00,
	WHOLE = 0x01,
	SPECIFIC = 0x02,
}
var product_list_status = Status.GENERIC
var selected_product = ""
var update_whole_list = true

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals = get_node("/root/Globals")
	Database = get_node("/root/Database")
	Serial = get_node("/root/Serial")
	self.set_position(Vector2(50, 131))
	self.set_size(Vector2(1000, 600))
	self.set_max_columns(3)
	self.fixed_column_width = 300
	img_mgr = DirAccess.open("images")
	file_mgr = DirAccess.open("scripts/ai")
	time_elapsed = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_elapsed += delta
	if time_elapsed >= 0.5 and !self.is_anything_selected() and product_list_status == Status.GENERIC:
		time_elapsed = 0
		load_generic_items()
	elif product_list_status == Status.WHOLE and update_whole_list:
		update_whole_list = false
		load_whole_items()
	pass

func _on_item_clicked(index, at_position, mouse_button_index):
	load_specific_items(index)
	pass # Replace with function body.


func _on_confirm_button_pressed():
	if self.is_anything_selected() == false:
		return
	Globals.buy_list.append([self.get_item_text(self.get_selected_items()[0]), float(Serial.weight[0]) + float(Serial.weight.substr(2))/1000, get_item_price()])
	Globals.buy_list_needs_update = true
	self.deselect_all()
	product_list_status ^= Status.SPECIFIC
	pass # Replace with function body.


func _on_back_button_pressed():
	update_whole_list = true
	if product_list_status & Status.SPECIFIC == Status.SPECIFIC:
		remove_all_items()
		product_list_status ^= Status.SPECIFIC
	else:
		get_tree().change_scene_to_file("res://scenes/BuyList.tscn")
	pass # Replace with function body.

func _on_list_button_pressed():
	update_whole_list = true
	product_list_status ^= Status.WHOLE
	pass # Replace with function body.

func remove_all_items():
	while self.item_count > 0:
		self.remove_item(0)

func load_item_image(product_name):
	var product_image = Image.load_from_file("images/%s.jpg" % product_name)
	product_image.resize(300, 300)
	product_image = ImageTexture.create_from_image(product_image)
	return product_image
	
func load_generic_items():
	remove_all_items()
	top_results_file = FileAccess.open("scripts/ai/top_results", FileAccess.READ)
	for i in range(1,4):
		var product_name = top_results_file.get_line()
		var product_image = load_item_image(product_name)
		self.add_item(product_name, product_image)
	top_results_file.close()
		
func load_specific_items(index):
	if product_list_status & Status.SPECIFIC == Status.SPECIFIC:
		return
	var product = self.get_item_text(index)
	var item_checker = FileAccess.open("images/info.txt", FileAccess.READ)
	while true:
		var line = item_checker.get_line()
		if line.length() == 0:
			break
		if line.begins_with("generic " + product):
			update_whole_list = true
			remove_all_items()
			product_list_status |= Status.SPECIFIC
		if line.begins_with("specific " + product):
			line = line.erase(0, "specific ".length())
			var product_name = line.split(",")[0]
			var product_image = load_item_image(product_name)
			self.add_item(product_name, product_image)
		elif line.begins_with("specific-notype " + product):
			break
	item_checker.close()

func load_whole_items():
	remove_all_items()
	var item_checker = FileAccess.open("images/info.txt", FileAccess.READ)
	while true:
		var line = item_checker.get_line()
		if line.length() == 0:
			break
		if line.begins_with("generic") or line.begins_with("specific-notype"):
			var product_name = line.split(" ", true, 1)[1].split(",")[0]
			var product_image = load_item_image(product_name)
			self.add_item(product_name, product_image)

func get_item_price():
	var item_name = self.get_item_text(self.get_selected_items()[0])
	var item_checker = FileAccess.open("images/info.txt", FileAccess.READ)
	while true:
		var line = item_checker.get_line()
		if line.length() == 0:
			break
		if line.begins_with("specific " + item_name) or line.begins_with("specific-notype " + item_name):
			return float(line.substr(line.length() - 5))
