extends Control

@onready var final_score_label = $FinalScore 

func set_score(score):
	final_score_label.text = "%d" % score

func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
