extends Area2D

signal coin_collected

func _ready():
	$AnimSprite.play("idle")

func _on_body_entered(body):
	if body.is_in_group("Player"):
		set_collision_layer_value(4, false)
		set_collision_mask_value(1, false)
		$AnimPlayer.play("collect")
		$AudioPlayer.play()
		coin_collected.emit()


func _on_anim_player_animation_finished(anim_name):
	queue_free()
