extends Control

var life_texture = load("res://scenes/UI/life_texture_rect.tscn")

var player: Player
var life_container: HBoxContainer
var score: Label
var game_over_screen: Control

signal retry_button_clicked
signal exit_button_clicked
# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_parent().get_children()[0].get_children():
		if("Player" in child.name):
			player = child
			break
	life_container = $LifeContainer
	for idx in player.life:
		var lifeTextureNode = life_texture.instantiate()
		life_container.add_child(lifeTextureNode)
	score = $Score
	game_over_screen = $GameOverScreen
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	pass


func _on_player_change_score(player_score: int):
	score.text = str(player_score)
	pass # Replace with function body.


func _on_player_change_life(player_life: int):
	var child_count = life_container.get_child_count()
	#player_life
	for index in child_count:
		if(index >= player_life):
			life_container.get_children()[index].modulate = "ffffff70"
	pass # Replace with function body.

func _on_game_over_button_down():
	emit_signal("retry_button_clicked")
	pass # Replace with function body.


func _on_exit_button_down():
	emit_signal("exit_button_clicked")	
	pass # Replace with function body.


func _on_player_on_destroy():
	game_over_screen.visible = true
	pass # Replace with function body.
