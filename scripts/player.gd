extends CharacterBody2D

var speed = 200
@export var bullet_scene: PackedScene
@export var bullets: Node2D
var fire_point: Node2D  # Punto de disparo, como un Node2D en el arma
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fire_point = $"player2/cañon2"
	pass # Replace with function body.

func _input(event):
	# Detectar disparo
	if event.is_action_pressed("fire"):
		shoot()

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = fire_point.global_position

	# Direcció cap al ratolí
	var mouse_direction = (get_global_mouse_position() - fire_point.global_position).normalized()
	var distance_to_cursor = fire_point.global_position.distance_to(get_global_mouse_position())
	if (distance_to_cursor < 50):
		# Limitar l'angle de desviació
		var max_angle = deg_to_rad(0.1)
		var forward_direction = Vector2(cos(fire_point.global_rotation), sin(fire_point.global_rotation)).normalized()
		var angle_between = forward_direction.angle_to(mouse_direction)
		
		# Limitar la direcció
		if abs(angle_between) > max_angle:
			mouse_direction = forward_direction.rotated(clamp(angle_between, -max_angle, max_angle))
	
	bullet.direction = mouse_direction
	bullet.rotation = mouse_direction.angle()
	bullets.add_child(bullet)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Movimiento básico con las teclas de flechas
	var direction = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	position += direction.normalized() * speed * delta
	
	var mouse_position = get_global_mouse_position()
	$"player2".look_at(mouse_position)
