extends Control

@onready var highscore_label = $HighScore
@onready var credits_menu = $UI/Credits
@onready var controls_menu = $UI/Controls

func _ready():
	var score = load_highscore()
	highscore_label.text = "Highscore: %d" % score
 
func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/delivery_game.tscn")

func load_highscore():
	var cfg = ConfigFile.new()
	if cfg.load("user://savegame.cfg") == OK:
		return int(cfg.get_value("game", "highscore", 0))
	return 0

func _on_credits_button_pressed() -> void:
	credits_menu.visible = true

func _on_controls_button_pressed() -> void:
	controls_menu.visible = true

func _on_credits_back_button_pressed() -> void:
	credits_menu.visible = false
	
func _on_controls_back_button_pressed() -> void:
	controls_menu.visible = false
