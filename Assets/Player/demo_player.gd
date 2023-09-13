extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -800.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction
var can_move = true

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("move_jump") and is_on_floor() and can_move:
		velocity.y = JUMP_VELOCITY
		$AudioPlayer.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("move_left", "move_right")
	if can_move:
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


func death_anim():
	$ColShape.disabled = true
	set_collision_layer_value(1, false)
	set_collision_mask_value(2, false)
	set_collision_mask_value(3, false)
	set_collision_mask_value(4, false)
	$AnimPlayer.play("die")


func _on_anim_player_animation_finished(anim_name):
	queue_free()
