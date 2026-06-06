extends Button

func _ready():
	pass

func _on_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.5, 0.5), 0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)

func _on_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)

func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/about.tscn")
