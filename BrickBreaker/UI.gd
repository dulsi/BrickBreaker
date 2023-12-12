extends CanvasLayer

@onready var levellbl = $levellbl
@onready var score_lbl = %score
@onready var life_lbl = %life

var score = 0
var life = 3

func _ready():
	$pause_menu.hide()
	get_tree().paused = true
	var lev = create_tween()
	levellbl.position.x = 166
	lev.tween_property(levellbl, "position:x",0,0.5)
	lev.tween_property(levellbl, "position:x",-166,0.5).set_delay(2)
	lev.tween_callback(func(): get_tree().paused = false)

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused == false:
			get_tree().paused = true
			$pause_menu.show()
		else:
			_on_resume_pressed()
			
	score_lbl.text = "%05d" % Player.score
	life_lbl.text = "Life: %02d" % Player.life
	levellbl.text = "Level %d" % Globals.current_level

func _on_resume_pressed():
	$pause_menu.hide()
	get_tree().paused = false
	
func _on_exit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_retry_pressed():
	Globals.reset()
	Player.reset()
	get_tree().reload_current_scene()
