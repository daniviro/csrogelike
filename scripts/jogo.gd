extends Node2D
@onready var crosshair_scene = preload("res://crosshair.tscn")
@onready var enemy_scene = preload("res://enemy.tscn")
var crosshair
@onready var spawn_area = $fondo.get_rect()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Ocultar el cursor estándar
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	# Instanciar el crosshair
	crosshair = crosshair_scene.instantiate()
	add_child(crosshair)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	crosshair.global_position = get_global_mouse_position()
	
	# Check distance between crosshair and player
	var distance = $player.fire_point.global_position.distance_to(get_global_mouse_position())
	crosshair.available = distance > 50
	
	# Spawn enemy if no one is alive
	if ($"enemies".get_children().size() == 0):
		spawnEnemy()

func spawnEnemy():
	var enemy = enemy_scene.instantiate()
	# Posicion aleatoria 
	enemy.global_position = _get_random_position() 
	$enemies.add_child(enemy)
	
func _get_random_position():
	var x = randf_range(spawn_area.position.x, spawn_area.position.x + spawn_area.size.x)
	var y = randf_range(spawn_area.position.y, spawn_area.position.y + spawn_area.size.y)
	var position = Vector2(x, y)
	
	if position.distance_to($player.global_position) < 150:
		position = _get_random_position()
	
	return position
