extends CharacterBody2D
class_name Bullet

@export var speed = 800
var direction = Vector2.ZERO

func _ready():
	$Timer.start()
	
func _on_Timer_timeout():
	queue_free()

func _physics_process(delta):
	# Mueve la bala en la dirección especificada
	velocity = direction * speed
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		
		if collider is Enemy:
			queue_free()
			collider.hit()
