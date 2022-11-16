extends Node
@onready var globals = get_node("/root/Constants")

var main_menu_packed = load("res://MainMenu.tscn")
var player: Player
var game_container
var game_data = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	var h = ProjectSettings.get("display/window/size/viewport_height")
	var w = ProjectSettings.get("display/window/size/viewport_width")	
	player = $GameContainer/Player	
	game_container = $GameContainer
	player.position = Vector2(w/2, h * .75)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	pass

func _on_ui_retry_button_clicked():
	get_tree().reload_current_scene()	
	pass # Replace with function body.


func _on_ui_exit_button_clicked():
	get_tree().change_scene_to_packed(main_menu_packed)
	pass # Replace with function body.


func _on_player_on_destroy():
	var file = ConfigFile.new()
	var err = file.load(globals.save_path)
	var best_score = 0
	if(err == OK):
		best_score = file.get_value("data", "game_data").best_score
	best_score = max(best_score, player.score)
	game_data["best_score"] = best_score
	file.set_value("data", "game_data", game_data)
	file.save(globals.save_path)
	pass # Replace with function body.
