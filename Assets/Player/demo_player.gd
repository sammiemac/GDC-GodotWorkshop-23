extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -800.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimSprite.flip_h = false
		$AnimSprite.play("walk")
		if direction < 0: $AnimSprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimSprite.play("idle")
	
	if not is_on_floor():
		$AnimSprite.play("jump")

	move_and_slide()


func bounce():
	velocity.y = JUMP_VELOCITY * 0.5
