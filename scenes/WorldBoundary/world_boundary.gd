extends Node2D

func _on_bottom_boundary_body_entered(body):
	_delete_body(body)
	pass # Replace with function body.


func _on_up_boundary_body_entered(body):
	if("Bullet" in body.name):
		_delete_body(body)
	pass # Replace with function body.


func _on_left_clear_boundary_body_entered(body):
	_delete_body(body)
	pass # Replace with function body.


func _on_right_clear_boundary_body_entered(body):
	_delete_body(body)
	pass # Replace with function body.


func _delete_body(body):
	body.queue_free()
