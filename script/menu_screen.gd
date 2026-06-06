extends Node2D

func _ready() -> void:
	# Memastikan saat menu dibuka, Dialogic benar-benar bersih total
	if Engine.has_meta("Dialogic"):
		Dialogic.end_timeline()
