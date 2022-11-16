extends Control
@onready var globals = get_node("/root/Constants")

var packed = load("res://scenes/game.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	var file = ConfigFile.new()
	file.load(globals.save_path)
	var game_data = file.get_value("data", "game_data")
	$VBoxContainer/ScoreLabel.text = str(game_data.best_score)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_button_down():
	get_tree().change_scene_to_packed(packed)
	pass # Replace with function body.
