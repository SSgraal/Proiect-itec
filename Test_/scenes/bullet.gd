extends CharacterBody2D

var speed = 2000  # Set to your bullet's speed
var direction = Vector2.ZERO  # This will be set when the bullet is fired

func _physics_process(delta):
	position += direction * speed * delta
