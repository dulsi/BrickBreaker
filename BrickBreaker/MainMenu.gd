extends Control

func _ready():
	$Scores.hide()

func _on_scores_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() == false:
			$Scores.hide()
			$menu.show()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Game.tscn")

func _on_play2_pressed():
	get_tree().change_scene_to_file("res://Game2.tscn")

func _on_highscore_pressed():
	$menu.hide()
	$Scores.show()


func _on_exit_pressed():
	get_tree().quit()
