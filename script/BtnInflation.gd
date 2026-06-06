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
	Dialogic.start("shopping")
	Dialogic.signal_event.connect(_on_signal)

func _on_signal(signal_passed_in):
	match signal_passed_in:
		"DoneGame3":
			print("lanjut ke gamenya")
			
			# Pastikan timeline Dialogic diakhiri/dibersihkan
			Dialogic.end_timeline()
			
			# Pindah ke scene inflation
			get_tree().change_scene_to_file("res://scene/inflation_screen.tscn")
