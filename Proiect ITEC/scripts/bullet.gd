extends CharacterBody2D

var speed = 2000  # Set to your bullet's speed
var direction = Vector2.ZERO  # This will be set when the bullet is fired
var bulletDamage = 10
var screen_size

@onready var enemy = get_node("/root/main/enemy")
@onready var player = get_node("/root/main/player")


func _ready():
	screen_size = DisplayServer.screen_get_size(DisplayServer.window_get_current_screen())

func _physics_process(delta):
	position += direction * speed * delta
	if(position.x <= 0 or position.y <= 0 or position.x >= screen_size.x or position.y >= screen_size.y):
		queue_free()
		print("bullet left")
	

func _on_area_2d_body_entered(body):
		if(body.name == "enemy"):
			queue_free()
			enemy.hp -= bulletDamage
		if(body.name == "player"):
			queue_free()
			player.hp -= bulletDamage
