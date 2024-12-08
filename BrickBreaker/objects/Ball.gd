extends CharacterBody2D
var speed =  100
var dir = Vector2(-0.5,-0.5)
var start_pos
var start_dir
func _ready():
	start_dir = dir
	start_pos = position

func set_direction(direction):
	dir.y = direction.y
	dir.x = direction.x
	#failsafe to avoid 
	#infinite left right bouncing 
	#from player and left/right walls
	if dir.y == 0:
		dir.y = 0.5
	
func reset():
	dir = start_dir
	position = start_pos

func _physics_process(delta):
	#Check wall collisions
	if is_on_ceiling():
		dir.y = -dir.y
	if is_on_floor():
		dir.y = -dir.y
		if check_game_over():
			Player.life -= 1
			reset()
			#might use for upgrades
	if is_on_wall():
		dir.x = -dir.x
	#Check for Brick Collisions
	velocity.x = roundi(dir.x*speed);
	velocity.y = roundi(dir.y*speed);
	move_and_slide()
	check_for_blocks()
	
func check_game_over():
	for i in range(get_slide_collision_count()):
		var col :KinematicCollision2D= get_slide_collision(i)
		var colobj = col.get_collider()
		if colobj == null:
			return
		if colobj.is_in_group("walls"):
			if Globals.balls > 1:
				queue_free()
				Globals.remove_ball()
			else:
				return true
		else:
			return false
			
func check_for_blocks():
	if get_slide_collision_count() == 0:
		return
	var col :KinematicCollision2D= get_slide_collision(0)
	var colobj = col.get_collider()
	if colobj is Block:
		colobj.take_damage()
