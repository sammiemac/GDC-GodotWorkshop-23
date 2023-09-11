extends Area2D

signal coin_collected

func _ready():
	$AnimSprite.play("idle")

func _on_body_entered(body):
	if body.is_in_group("Player"):
		$ColShape.disabled = true
		coin_collected.emit()
		$AnimPlayer.play("collect")

func _on_anim_player_animation_finished(anim_name):
	queue_free()
