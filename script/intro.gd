extends Node2D

func _ready():
	$CanvasLayer/TextureRect/AnimationPlayer.play("fadein")
	await get_tree().create_timer(6).timeout
	$CanvasLayer/TextureRect/AnimationPlayer.play("fadeout")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scene/menu_screen.tscn")
	
