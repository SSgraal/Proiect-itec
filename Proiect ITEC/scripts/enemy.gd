extends CharacterBody2D

enum{
	WAIT,
	CHARGE,
	SHOOT
}

var speed = 300.0
var bulletSpeed = 100
var bullet = preload("res://scenes/bullet.tscn")
var bullet_instance
var state=CHARGE#change to WAIT
var motion = Vector2()
var can_shoot = true
var timer
var hp = 30
var alive = true
var player_is_alive = true
@onready var player = get_node("/root/main/player")

func _process(delta):
	if(hp <= 0 and alive == true):
		alive = false
		$AnimatedSprite2D.play("death")
		player.hp += 30
	var Player = get_parent().get_node("player")
	if(alive == true):
		match state:
			WAIT:
				pass#make the check for being in the same room
			CHARGE:
				position += (Player.position - position)/50
				look_at(Player.position)
				move_and_collide(motion)
				var distance = global_position.distance_to(Player.global_position)
				if (distance < 300):
					state = SHOOT
			SHOOT:
				speed = 0
				look_at(Player.position)
				if can_shoot:
					fire()
					can_shoot = false
					var timer = get_tree().create_timer(0.5) # Create a one-time timer
					timer.connect("timeout", Callable(self, "_on_timer_timeout"))
				var distance = global_position.distance_to(Player.global_position)
				if (distance > 400):
					state = CHARGE

func fire():
	bullet_instance = bullet.instantiate()
	var offset = Vector2(70, 0).rotated(rotation)  # Adjust the offset here
	bullet_instance.position = position + offset
	bullet_instance.rotation = rotation
	bullet_instance.direction = Vector2(1, 0).rotated(rotation)
	get_parent().add_child(bullet_instance) 

func _on_timer_timeout():
	can_shoot = true
