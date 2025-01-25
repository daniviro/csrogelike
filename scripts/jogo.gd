extends Node2D
@onready var crosshair_scene = preload("res://crosshair.tscn")
var crosshair

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Ocultar el cursor estándar
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	# Instanciar el crosshair
	crosshair = crosshair_scene.instantiate()
	add_child(crosshair)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	crosshair.global_position = get_global_mouse_position()
	
	# Check distance between crosshair and player
	var distance = $player.global_position.distance_to(get_global_mouse_position())
	crosshair.available = distance > 50
