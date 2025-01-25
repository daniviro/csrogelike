extends CharacterBody2D

@export var speed = 800
var direction = Vector2.ZERO

func _ready():
	$pium.play()
	$Timer.start()
	
func _on_Timer_timeout():
	queue_free()

func _physics_process(delta):
	# Mueve la bala en la dirección especificada
	velocity = direction * speed
	move_and_collide(velocity * delta)
