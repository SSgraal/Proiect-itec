extends CharacterBody2D

var player_speed = 7
var bullet = preload("res://scenes/bullet.tscn")
var bullet_instance

func _process(delta):
	player_movement()
	
func player_movement():
	if(Input.is_action_pressed("move_up")):
		position.y -= player_speed
	if(Input.is_action_pressed("move_down")):
		position.y += player_speed
	if(Input.is_action_pressed("move_right")):
		position.x += player_speed
	if(Input.is_action_pressed("move_left")):
		position.x -= player_speed
		
	look_at(get_global_mouse_position())
	
	if(Input.is_action_just_pressed("shoot")):	
		fire()
		
func fire():
	bullet_instance = bullet.instantiate()
	var offset = Vector2(70, 0).rotated(rotation)  # Adjust the offset here
	bullet_instance.position = position + offset
	bullet_instance.rotation = rotation
	bullet_instance.direction = Vector2(1, 0).rotated(rotation)
	get_parent().add_child(bullet_instance)
