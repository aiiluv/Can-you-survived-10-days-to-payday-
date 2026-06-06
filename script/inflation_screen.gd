extends Node2D

# Variabel Keuangan
var player_money = 200
var time_left = 30

# Jumlah barang yang berhasil dibeli
var eggs_bought = 0
var milk_bought = 0
var oil_bought = 0
var rice_bought = 0
var veggies_bought = 0

# Harga awal
var price_eggs = 15
var price_milk = 25
var price_oil = 40
var price_rice = 30
var price_veggies = 20

# Shopping list!
@onready var label_list_info = $CanvasLayer/List/Label


@onready var lbl_price_eggs = $CanvasLayer/Eggs/EggPrice
@onready var lbl_price_milk = $CanvasLayer/Milk/MilkPrice
@onready var lbl_price_oil = $CanvasLayer/Oil/OilPrice
@onready var lbl_price_rice = $CanvasLayer/Rice/RicePrice
@onready var lbl_price_veggies = $CanvasLayer/Veggies/VeggiesPrice

func _ready() -> void:
	Dialogic.start("shopping")
	await Dialogic.timeline_ended
	$GameTimer.start()
	$InflationTimer.start()
	update_market_ui()

func update_market_ui():
	lbl_price_eggs.text = "$" + str(price_eggs)
	lbl_price_milk.text = "$" + str(price_milk)
	lbl_price_oil.text = "$" + str(price_oil)
	lbl_price_rice.text = "$" + str(price_rice)
	lbl_price_veggies.text = "$" + str(price_veggies)
	
	# Update isi kotak putih
	label_list_info.text = (
		"SHOPPING LIST!\n" +
		"Remaining Money: $" + str(player_money) + "\n" +
		"Time Left: " + str(time_left) + "s\n\n" +
		"Cart:\n" +
		"- Eggs (Min. 1): " + str(eggs_bought) + "\n" +
		"- Milk (Min. 1): " + str(milk_bought) + "\n" +
		"- Oil (Min. 1): " + str(oil_bought) + "\n" +
		"- Rice (Min. 1): " + str(rice_bought) + "\n" +
		"- Veggies (Min. 1): " + str(veggies_bought)
	)

# --- SISTEM INFLASI ---
func _on_inflation_timer_timeout() -> void:
	if time_left > 0:
		price_eggs += randi_range(2, 4)
		price_milk += randi_range(3, 5)
		price_oil += randi_range(5, 8)
		price_rice += randi_range(4, 6)
		price_veggies += randi_range(2, 5)
		update_market_ui()

# --- HITUNG MUNDUR WAKTU GAME---
func _on_game_timer_timeout() -> void:
	if time_left > 0:
		time_left -= 1
		update_market_ui()
	else:
		$GameTimer.stop()
		$InflationTimer.stop()
		check_game_result() # Otomatis checkout 

func _on_eggs_pressed() -> void:
	if player_money >= price_eggs and time_left > 0:
		eggs_bought += 1
		player_money -= price_eggs
		update_market_ui()

func _on_milk_pressed() -> void:
	if player_money >= price_milk and time_left > 0:
		milk_bought += 1
		player_money -= price_milk
		update_market_ui()

func _on_oil_pressed() -> void:
	if player_money >= price_oil and time_left > 0:
		oil_bought += 1
		player_money -= price_oil
		update_market_ui()

func _on_rice_pressed() -> void:
	if player_money >= price_rice and time_left > 0:
		rice_bought += 1
		player_money -= price_rice
		update_market_ui()

func _on_veggies_pressed() -> void:
	if player_money >= price_veggies and time_left > 0:
		veggies_bought += 1
		player_money -= price_veggies
		update_market_ui()

func check_game_result():
	if eggs_bought >= 1 and milk_bought >= 1 and oil_bought >= 1 and rice_bought >= 1 and veggies_bought >= 1:
		get_tree().change_scene_to_file("res://scene/congrats.tscn")
	else:
		get_tree().change_scene_to_file("res://scene/bad_ending.tscn")

func _on_wait_timer_timeout() -> void:
	pass 
