extends Control

func _process(delta):
	get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_VIEWPORT
