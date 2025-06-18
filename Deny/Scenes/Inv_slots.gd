extends TextureRect

var was_dropped = false
var origin_texture = null

func _get_drag_data(at_position: Vector2) -> Variant:

	set_drag_preview(get_preview())
	print("dragged")
	return TextureRect 

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is Texture2D

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var temp = texture_rect.texture
	texture_rect.texture = data.texture
	data.texture = temp

func get_preview():
	var preview_texture = TextureRect.new()
	
	preview_texture.texture = texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(30,30)
	
	var preview = Control.new()
	preview.add_child(preview_texture)
	
	return preview
