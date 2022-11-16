extends CharacterBody2D
class_name Player

@export var SPEED := 100.0
@export var BOOST := 150.0
@export var BRAKE := -100.0

var life = 3

var bullet_ref := load("res://scenes/Bullet/bullet.tscn")
var unlocked_types = ["u_1"]
var shoot_timer: Timer 
var shoot_wait_time: float 
var acceleration: float
var bullet_pool
var score = 0

var player_sprite: Sprite2D
var explode_animation: AnimatedSprite2D

signal change_velocity
signal change_score
signal change_life
signal on_destroy


func _ready():
	shoot_timer = $ShootTimer
	shoot_wait_time = shoot_timer.wait_time
	player_sprite = $Sprite2D
	explode_animation = $ExplodeAnimation
	
	for child in get_parent().get_children():
		if("BulletPool" in child.name):
			bullet_pool = child
	pass
	
func _physics_process(delta):
	if(life>0):
		var direction := Vector2.ZERO		
		direction.x = Input.get_axis("ui_left","ui_right")	
		update_vertical_velocity()
		velocity = direction * SPEED
		move_and_slide()
		

func update_vertical_velocity() -> void:
	var new_acceleration = 0.0
	if(Input.is_action_pressed("ui_up") and life>0):
		$FlareAnimation.animation = "speed_up"
		new_acceleration = BOOST
	elif(Input.is_action_pressed("ui_down")and life>0):
		$FlareAnimation.animation = "speed_down"
		new_acceleration = BRAKE
	else:
		$FlareAnimation.animation = "idle"	
	shoot_timer.wait_time = shoot_wait_time - new_acceleration/1000
	acceleration = new_acceleration
	emit_signal("change_velocity", acceleration)

func fire() -> void:	
	var bullet = bullet_ref.instantiate() as Bullet
	var vector := Vector2.UP            	
	bullet.linear_velocity = vector * 200		
	bullet.position = self.position
	bullet_pool.add_child(bullet)
	
func add_point(point):
	score += point
	emit_signal("change_score", score)

func receive_damage(damage: int):
		life -= damage
		emit_signal("change_life", life)
		if(life == 0):		
			destroy()
	
func destroy():
	emit_signal("on_destroy")
	shoot_timer.stop()
	explode_animation.visible = true
	explode_animation.play()
	player_sprite.visible = false
	await explode_animation.animation_finished
	visible = false
	

func _on_shoot_timer_timeout():
	fire()


func _on_area_2d_body_entered(body):
	if("Asteroid" in body.name):
		body.queue_free()
		receive_damage(1)
	pass # Replace with function body.

