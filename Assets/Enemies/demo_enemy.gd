extends CharacterBody2D

@export var speed = 100.0
@export var direction = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	$AnimSprite.play("move")
	
	if direction:
		velocity.x = speed * -1
		$AnimSprite.flip_h = false
	else:
		velocity.x = speed
		$AnimSprite.flip_h = true

	move_and_slide()

func _on_hit_box_body_entered(body):
	if body.is_in_group("player"):
		print("hit!")
