extends Node2D

var spawn_timer: Timer
var default_wait_time: float
var asteroid_pool: Node2D
var asteroid_ref := load("res://scenes/Asteroid/asteroid.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_timer = $SpawnTimer
	default_wait_time = spawn_timer.wait_time
	asteroid_pool = $AsteroidPool
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_change_velocity(speed):
	for child in asteroid_pool.get_children():
		var asteroid = child as Asteroid
		asteroid.linear_velocity = Vector2.DOWN * asteroid.speed * (1 if speed == 0 else (1.5 if speed > 0 else 0.25))
		var sub = speed*0.001
		spawn_timer.wait_time = default_wait_time - sub
	pass # Replace with function body.


func _on_spawn_timer_timeout():
	var xpos = randf_range(0, 128)
	var asteroid = asteroid_ref.instantiate() as Asteroid
	asteroid.position = Vector2(xpos, -50)
	asteroid.mass = randi_range(1, asteroid.max_mass) * 100
	asteroid.speed = 100
	asteroid.linear_velocity = Vector2.DOWN * asteroid.speed
	asteroid.angular_velocity = randf_range(-5,5)
	asteroid_pool.add_child(asteroid)	
	pass # Replace with function body.

