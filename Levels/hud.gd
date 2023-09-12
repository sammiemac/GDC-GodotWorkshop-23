extends Node2D

var coins = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD/CoinUI/CoinCount.text = str(coins)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if coins == 3:
		$HUD/CoinUI.visible = false
		$HUD/CompleteUI.visible = true


func _on_coin_collected():
	coins += 1
	_ready()


func _on_game_over(body):
	$HUD/CoinUI.visible = false
	$HUD/GameOverUI.visible = true
	body.bounce()
	body.death_anim()
	body.can_move = false


func _on_try_again_pressed():
	get_tree().change_scene_to_file("res://Levels/demo_level.tscn")
