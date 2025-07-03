extends CharacterBody2D

@export var speed = 200
@onready var package_sprite = $PackageSprite

var can_pickup = false
var current_package = null
var current_recipient = null
var recipients = []
var score = 0 

func _ready():
	position = Vector2(305,650)
	recipients = get_tree().get_nodes_in_group("recipients")

func _process(delta):
	var direction = Vector2.ZERO
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()  
	if can_pickup and Input.is_action_just_pressed("interact"):
		if current_package == null:
		# First-time pickup
			var pkg_data = PackageData.get_random_package()
			current_package = pkg_data
			show_package(pkg_data)
			$PickupSFX.play()
		else:
			# Check if any recipient still wants this package
			if not any_recipient_wants(current_package):
				# Reroll allowed
				var pkg_data = PackageData.get_random_package()
				current_package = pkg_data
				show_package(pkg_data)
				$PickupSFX.play()
			else:
				$ErrorSFX.play()
				print("Someone still wants this package! Can't reroll.")
	if current_recipient and Input.is_action_just_pressed("interact") and current_package:
		if packages_match(current_package, current_recipient.desired_package):
			$DeliverySFX.play()
			var fx = preload("res://scenes/delivery_particles.tscn").instantiate()
			fx.position = position
			fx.emitting = true 
			get_tree().current_scene.add_child(fx)
			print("Delivered successfully!")
			get_parent().add_score()
			current_package = null
			package_sprite.visible = false
			current_recipient.randomize_package()
		else:
			$ErrorSFX.play()
			print("Wrong package!")

func show_package(pkg): 
	package_sprite.texture = pkg.texture
	package_sprite.flip_h = pkg.flip_h
	package_sprite.visible = true

func packages_match(a, b):
	return a.id == b.id

func remove_package():
	current_package = null
	package_sprite.visible = false

func any_recipient_wants(package):
	for r in recipients:
		if r.desired_package.id == package.id:
			return true
	return false
