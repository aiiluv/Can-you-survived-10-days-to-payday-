extends Node2D

# Variable uang
var remaining_balance = 100
var needs_slot = 0
var savings_slot = 0
var emergency_slot = 0

# Variabel untuk melacak kategori aktif
var active_category = "needs"

@onready var remaining_label = $CanvasLayer/TextureRect/LabelSisa
@onready var coin_info_label = %KebutuhanPokok

@onready var btn_needs = $CanvasLayer/TextureRect/BtnKebutuhan
@onready var btn_savings = $CanvasLayer/TextureRect/BtnTabungan
@onready var btn_emergency = $CanvasLayer/TextureRect/BtnDarurat

@onready var btn_submit = $CanvasLayer/TextureRect/BtnSubmit

func _ready():
	btn_needs.modulate = Color.YELLOW
	update_ui()

func update_ui():
	remaining_label.text = "Remaining coins: " + str(remaining_balance)
	
	coin_info_label.text = "Needs = " + str(needs_slot) + "\nSavings = " + str(savings_slot) + "\nEmergency = " + str(emergency_slot)
	
	# Validasi tombol submit
	if remaining_balance == 0:
		btn_submit.disabled = false
	else:
		btn_submit.disabled = true

#========== Choose Categories (SUDAH DIPERBAIKI) ==============

func _on_btn_kebutuhan_pressed() -> void:
	active_category = "needs" # Memperbaiki target variabel
	btn_needs.modulate = Color.YELLOW
	btn_savings.modulate = Color.WHITE
	btn_emergency.modulate = Color.WHITE

func _on_btn_tabungan_pressed() -> void:
	active_category = "savings" # Memperbaiki target variabel
	btn_needs.modulate = Color.WHITE
	btn_savings.modulate = Color.YELLOW
	btn_emergency.modulate = Color.WHITE

func _on_btn_darurat_pressed() -> void:
	active_category = "emergency" # Memperbaiki target variabel
	btn_needs.modulate = Color.WHITE
	btn_savings.modulate = Color.WHITE
	btn_emergency.modulate = Color.YELLOW

#========== Btn plus & minus logic =========

func _on_btn_plus_pressed() -> void:
	if remaining_balance >= 10:
		if active_category == "needs":
			needs_slot += 10
		elif active_category == "savings":
			savings_slot += 10
		elif active_category == "emergency":
			emergency_slot += 10
			
		remaining_balance -= 10
		update_ui()

func _on_btn_minus_pressed() -> void:
	if active_category == "needs" and needs_slot >= 10:
		needs_slot -= 10
		remaining_balance += 10
	elif active_category == "savings" and savings_slot >= 10:
		savings_slot -= 10
		remaining_balance += 10
	elif active_category == "emergency" and emergency_slot >= 10:
		emergency_slot -= 10
		remaining_balance += 10
		
	update_ui()
	
#=========== submit btn =============

func _on_btn_submit_pressed() -> void:
	if needs_slot == 50 and savings_slot == 30 and emergency_slot == 20:
		get_tree().change_scene_to_file("res://scene/congrats.tscn")
	else:
		get_tree().change_scene_to_file("res://scene/bad_ending.tscn")
