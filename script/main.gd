extends Node2D

func _ready() -> void:
	Dialogic.start("welcome")
	Dialogic.signal_event.connect(_on_signal)

func _on_signal(signal_passed_in):
	match signal_passed_in:
		"ending":
			print("yeyy end!")
			
			# Mengubah variabel global menjadi true karena player berhasil menamatkan story
			GlobalData.sudah_tamat_story = true
			
			# Pastikan timeline Dialogic diakhiri/dibersihkan
			Dialogic.end_timeline()
			
			# Pindah ke scene menu utama
			get_tree().change_scene_to_file("res://scene/menu_screen.tscn")
