extends Sprite2D

@export var green_texture: Texture
@export var red_texture: Texture

var available: bool = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (available):
		texture = green_texture
	else:
		texture = red_texture
