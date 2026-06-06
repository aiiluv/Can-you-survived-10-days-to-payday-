extends Button

# GANTI BARIS INI: Dari yang sebelumnya memakai % menjadi pakai ../
@onready var tips_win = $"../TipsWin"

func _ready():
	set_process_input(true)

func _on_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.21, 0.21), 0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)

func _on_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.2, 0.2), 0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)

func _on_pressed() -> void:
	# Sekarang ini dijamin aman dari null instance
	tips_win.visible = true

func _input(event: InputEvent) -> void:
	if tips_win.visible and event.is_action_pressed("ui_accept"):
		tips_win.visible = false
		get_viewport().set_input_as_handled()
