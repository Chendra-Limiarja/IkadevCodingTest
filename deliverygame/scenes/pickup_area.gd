extends Area2D

func _on_body_entered(body): 
	if body.name == "Player":
		body.can_pickup = true

func _on_body_exited(body):
	if body.name == "Player":
		body.can_pickup = false
