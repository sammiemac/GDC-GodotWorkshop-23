extends CharacterBody2D

@export var speed = 100.0
@export var direction = 1

signal enemy_hit(body: Node2D)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	if direction > 0:
		$AnimSprite.flip_h = true
	elif direction < 0:
		$AnimSprite.flip_h = false
	
	$FloorChecker.position.x = $ColShape.shape.get_size().x * direction

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_wall() or not $FloorChecker.is_colliding():
		direction *= -1
		$AnimSprite.flip_h = not $AnimSprite.flip_h
		$FloorChecker.position.x = $ColShape.shape.get_size().x * direction

	if speed > 0:
		$AnimSprite.play("move")
	
	velocity.x = speed * direction

	move_and_slide()

func _on_hit_box_body_entered(body):
	$AnimSprite.play("hit")
	$AnimPlayer.play("hit")
	$AudioPlayer.play()
	speed = 0
	set_collision_layer_value(3, false)
	set_collision_mask_value(1, false)
	body.bounce()


func _on_damage_box_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("enemy_hit", body)


func _on_anim_player_animation_finished(anim_name):
	queue_free()
