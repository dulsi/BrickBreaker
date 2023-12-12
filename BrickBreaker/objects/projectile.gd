class_name Projectile extends Area2D
var SPEED =  200

func _process(delta):
	position.y -= SPEED * delta

func _on_body_entered(body):
	if body is Block:
		body.take_damage()
		queue_free()
	if body.is_in_group("walls"):
		queue_free()
	
	
