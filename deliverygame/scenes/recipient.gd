extends Area2D

@export var character_sprite: Texture
var desired_package = null

func _ready():
	$Sprite2D.texture = character_sprite
	randomize_package()

func randomize_package():
	desired_package = PackageData.get_random_package()
	$WantedSprite.texture = desired_package.texture 
	$WantedSprite.flip_h = desired_package.flip_h 

func _on_body_entered(body):
	if body.name == "Player":
		body.current_recipient = self 

func _on_body_exited(body):
	if body.name == "Player" and body.current_recipient == self:
		body.current_recipient = null 
