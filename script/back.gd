extends Button

func _ready():
	pass

func _on_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.21, 0.21), 0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)

func _on_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.2, 0.2), 0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)

func _on_pressed() -> void:
	Dialogic.paused = false 
	var current_timeline = Dialogic.current_timeline
	if current_timeline:
		Dialogic.end_timeline()
	await get_tree().create_timer(3.0).timeout
	# 4. Pindah ke menu screen
	get_tree().change_scene_to_file("res://scene/menu_screen.tscn")
