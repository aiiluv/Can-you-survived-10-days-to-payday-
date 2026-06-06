extends Button

func _ready():
	pass

func _on_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.138, 0.138), 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _on_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.135, 0.135), 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _on_pressed() -> void:
	Dialogic.start("go_to_payday")
	await Dialogic.timeline_ended
	get_tree().change_scene_to_file("res://scene/payday_screen.tscn")
