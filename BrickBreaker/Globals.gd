extends Node
signal add_ball()
signal level_complete(level)
var blocks = 0

var current_level = 1
var balls = 1
func reset():
	current_level = 1
	blocks = 0
	level_complete.emit(0)

func add_block():
	blocks += 1
func remove_block():
	blocks -= 1
	if blocks <= 0:
		level_complete.emit(current_level)

func add_second_ball():
	if balls < 2:
		add_ball.emit()
		balls += 1
func remove_ball():
	if balls > 0:
		balls -= 1
