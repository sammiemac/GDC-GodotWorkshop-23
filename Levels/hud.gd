extends CanvasLayer

var coins = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$CoinUI/CoinCount.text = str(coins)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if coins == 3:
		$CoinUI.visible = false
		$CompleteUI.visible = true


func _on_coin_collected():
	coins += 1
	_ready()


func _on_fall_zone_body_entered(body):
	if body.is_in_group("Player"):
		$CoinUI.visible = false
		$GameOverUI.visible = true


func _on_try_again_pressed():
	get_tree().change_scene_to_file("res://Levels/demo_level.tscn")