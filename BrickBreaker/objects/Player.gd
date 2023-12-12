class_name Player extends Area2D

var velocity = Vector2()
@onready var col = $col
@onready var sprite = $Sprite2D
@onready var blaster_timer = $BTimer
@onready var blaster_sprite = $blaster
var shape :RectangleShape2D = null

var ball = preload("res://objects/Ball.tscn")
var projectile = preload("res://objects/projectile.tscn")
@export var speed = 300

@export var MIN_X = 16
@export var MAX_X = 144

static var life = 3
static var score = 0
var stretch_status = 0 #-1=small 0=normal 1=large
var size_offset = 0
var has_blaster = false
func _ready():
	Globals.add_ball.connect(add_new_ball)
	stretch_status = 0
	shape= col.shape
	shape.size.x = 34

func _process(delta):
	var dir = Input.get_axis("left","right")
	velocity.x = dir * speed
	position.x += roundi(velocity.x*delta)
	position.x = clamp(position.x,MIN_X+size_offset,MAX_X-size_offset)
	if life <= 0:
		reset()
		get_tree().reload_current_scene()
		
	if Input.is_action_just_pressed("fire"):
		if has_blaster:
			var p = projectile.instantiate()
			get_parent().add_child(p)
			p.position = position + Vector2(0,-5)

func add_new_ball():
	var b = ball.instantiate()
	get_parent().add_child(b)
	b.position = position + Vector2(0,-5)

func _on_body_entered(body):
	if body.is_in_group("ball"):
		body.set_direction(get_direction(body.position))
		await get_tree().create_timer(0.05).timeout


func get_direction(pos:Vector2):
	return position.direction_to(pos)

static func reset():
	score = 0
	life = 3

func set_stretch(dir:int):
	var t = create_tween().set_parallel(true)
	match stretch_status:
		0:
			if dir == 1:
				size_offset = 16
				stretch_status = 1
				t.tween_property(shape,"size:x",68,0.1)
				t.tween_property(sprite,"scale:x",2,0.1)
			elif dir == -1:
				stretch_status = -1
				size_offset = -8
				t.tween_property(shape,"size:x",34/2,0.1)
				t.tween_property(sprite,"scale:x",0.5,0.1)
		1:
			if dir == -1:
				stretch_status = 0
				size_offset = 0
				t.tween_property(shape,"size:x",34,0.1)
				t.tween_property(sprite,"scale:x",1,0.1)
		-1:
			if dir == 1:
				stretch_status = 0
				size_offset = 0
				t.tween_property(shape,"size:x",34,0.1)
				t.tween_property(sprite,"scale:x",1,0.1)

func _on_area_entered(area):
	if area.is_in_group("stretch"):
		set_stretch(1)
	if area.is_in_group("shrink"):
		set_stretch(-1)
	if area.is_in_group("multiball"):
		Globals.add_second_ball()
	if area.is_in_group("blaster"):
		has_blaster = true
		blaster_sprite.show()
		blaster_timer.start()
	area.queue_free()

func _on_b_timer_timeout():
	has_blaster = false
	blaster_sprite.hide()
