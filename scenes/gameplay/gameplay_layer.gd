extends CanvasLayer

@onready var failState = $MarginContainer/Control/GameOver
@onready var victoryState = $MarginContainer/Control/Victory
@onready var stopwatch: Label = $MarginContainer/Control/Victory/StopWatch

@onready var tutorialLabel = $tutorial
@onready var bethebulletLabel = $BeeTheBullet

var time_elapsed := 0.0
var is_stopped := false

func _ready():
	await get_tree().create_timer(10).timeout
	tutorialLabel.visible = false
	
func showBeethebullet():
	bethebulletLabel.visible = true
	await get_tree().create_timer(8).timeout
	bethebulletLabel.visible = false

func VictoryState():
	victoryState.visible = true
	is_stopped = true

func MainMenu():
	Game.change_scene_to_file("res://scenes/menu/menu.tscn", {"show_progress_bar": false})


func _process(delta: float) -> void:
	if !is_stopped:
		time_elapsed += delta
		stopwatch.text = str(time_elapsed).pad_decimals(2)
	
func FailState():
	failState.visible = true

func Restart():

	var params = {
			"show_progress_bar": true,
			"a_number": 10,
			"a_string": "Ciao!",
			"an_array": [1, 2, 3, 4],
			"a_dict": {
				"name": "test",
				"val": 15
			},
	}
	SoundManager.PlaySound("menu_click")
	MusicPlayer.PlayMusicClip("in_a_heartbeat", 2)
	Game.change_scene_to_file("res://scenes/gameplay/gameplay.tscn", params)
