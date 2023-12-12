class_name Block extends StaticBody2D

@export var color:Color
@export var hp = 1
@onready var sprite = $img

var upgrade = preload("res://upgrade.tscn")

func take_damage(amount:=1):
	hp -= amount
	if hp <= 0:
		drop_upgrade()
		Globals.remove_block()
		Player.score += 15
		queue_free()

func set_color(col:Color):
	sprite.modulate = col

func drop_upgrade():
	var chance = randf()
	if chance > 0.8:
		var u = upgrade.instantiate()
		get_parent().add_child(u)
		u.position = position
		u.set_type(randi()%4)
		
