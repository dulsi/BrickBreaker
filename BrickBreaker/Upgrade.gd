extends Area2D
const STRETCH = 0
const SHRINK = 1
const BLASTER = 2
const MULTIBALL = 3
func _process(delta):
	position.y += 20 * delta

func set_type(type:int):
	match type:
		STRETCH:
			$stretch.show()
			add_to_group("stretch")
		SHRINK:
			$shrink.show()
			add_to_group("shrink")
		BLASTER:
			$blaster.show()
			add_to_group("blaster")
		MULTIBALL:
			$multiball.show()
			add_to_group("multiball")

func _on_body_entered(body):
	if body.is_in_group("walls"):
		queue_free()
