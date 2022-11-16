class_name Bullet
extends RigidBody2D

var explosion_animation: AnimatedSprite2D
var sprite: Sprite2D
func _ready():
	explosion_animation = $Explosion
	sprite = $Sprite2D

func destroy(target_velocity: Vector2):
	sprite.visible = false
	linear_velocity = target_velocity
	explosion_animation.visible = true	
	explosion_animation.play()
	await explosion_animation.animation_finished
	queue_free()
