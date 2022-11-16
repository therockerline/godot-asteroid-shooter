class_name Asteroid
extends RigidBody2D

@export var life := 0
@export var speed := 0.0
var player: Player
var explosion_animation: AnimatedSprite2D
var asteroid_sprite: Sprite2D
var life_bar: LifeBar
var max_mass := 5.0
# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_node("/root/Game").get_children()[0].get_children():
		if("Player" in child.name):
			player = child
	explosion_animation = $Explosion
	asteroid_sprite = $Sprite2D
	if(life == 0):
		life = max_mass*100/mass		
		asteroid_sprite.modulate = "ffffffff"
	var scaling = Vector2.ONE + (Vector2.ONE * life/max_mass);
	for child in get_children():
		child.set_scale(scaling)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(life <= 0 and !explosion_animation.visible):
		player.add_point(mass)
		explosion_animation.visible = true
		explosion_animation.play()
		await explosion_animation.animation_finished		
		self.queue_free()
	pass


func _on_area_2d_body_entered(body):
	if("Bullet" in body.name):
		(body as Bullet).destroy(self.linear_velocity)
		life -= 1		
		asteroid_sprite.modulate = "ffffffff"				
	pass # Replace with function body.
