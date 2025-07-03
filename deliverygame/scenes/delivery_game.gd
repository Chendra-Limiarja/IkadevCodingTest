extends Node2D

@onready var timer = $GameTimer
@onready var game_over_menu = $UI/GameOverMenu
@onready var timer_label = $UI/TimerLabel
@onready var score_label = $UI/HighScoreLabel
@onready var new_highscore_label = $UI/GameOverMenu/NewHighScore
@onready var pause_menu = $UI/PauseMenu

var score = 0
var time_left = 60.0

func _ready():
	score = 0
	time_left = 60.0
	game_over_menu.visible = false
	timer.start()
	score_label.text = "Score: 0"
	set_process(true) 

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			resume_game()
		else:
			pause_game()
	time_left -= delta
	timer_label.text = "Time: %.1f" % time_left
	if time_left <= 0:
		end_game() 

func pause_game():
	get_tree().paused = true
	pause_menu.visible = true

func resume_game():
	get_tree().paused = false
	pause_menu.visible = false

func add_score():
	score += 5
	score_label.text = "Score: %d" % score

func end_game():
	# Disable player movement
	get_node("Player").set_process(false)
	
	var previous_highscore = load_highscore()
	
	if score > previous_highscore:
		save_highscore(score)
		new_highscore_label.visible = true
	else:
		new_highscore_label.visible = false
		
	game_over_menu.visible = true
	game_over_menu.set_score(score)
	save_highscore(score)

func load_highscore():
	var config = ConfigFile.new()
	if config.load("user://savegame.cfg") == OK:
		return int(config.get_value("game", "highscore", 0))
	return 0

func save_highscore(score):
	var config = ConfigFile.new()
	var path = "user://savegame.cfg"
	
	if config.load(path) == OK:
		var prev = config.get_value("game", "highscore", 0)
		if score > prev:
			config.set_value("game", "highscore", score)
	else:
		config.set_value("game", "highscore", score)
	
	config.save(path)


func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false  # unpause before changing scene
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_continue_button_pressed() -> void:
	resume_game()
