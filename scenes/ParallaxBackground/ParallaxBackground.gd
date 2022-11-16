extends ParallaxBackground

var speed = 100
var player: Player
var parallax_layer: ParallaxLayer
var parallax_layer2: ParallaxLayer
# Called when the node enters the scene tree for the first time.
func _ready():
	for item in get_parent().get_children():
		if("Player" in item.name):
			player = item
	parallax_layer = $ParallaxLayer
	parallax_layer2= $ParallaxLayer2
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var motion_offset = Vector2(
		player.velocity.x/80,
		speed + player.acceleration/2
	)
	parallax_layer.motion_offset += motion_offset * delta
	var motion_offset2 = Vector2(
		player.velocity.x/20,
		speed + player.acceleration/1.85
	)
	parallax_layer2.motion_offset += motion_offset2 * delta
	pass

