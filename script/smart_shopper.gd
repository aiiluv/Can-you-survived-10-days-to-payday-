extends Node2D

# Var keuangan player
var current_budget = 50
var current_mission_index = 0

#catat pengeluaran struk akhir
var receipt_items = []
var total_spent = 0
var total_savable = 0
var skipped_all_count = 0 # Melacak berapa kali pemain memilih untuk skip

#struktur data misi belanja
var missions = [
	{
		"title": "Case 1: Thirsty After Work",
		"item_name": "Trendy Iced Coffee",
		"main_price": 9,
		"desc": """Item: Trendy Iced Coffee
					Price: 18 coins (50% Discount -> 9 coins!)
					If skipped: No major impact.
					Alternative: Bring your own water (Free)""",
		"has_alternative": false,
		"alt_name": "Own Water (Free)",
		"alt_price": 0,
		"label_buy": "Optional / Impulsive purchase",
		"label_alt": "Smart choice!",
		"image_node_name": "case1"
	},
	
	{
		"title": "Case 2: Broken Work Shoes",
		"item_name": "New Work Shoes",
		"main_price": 25,
		"desc": """Item: New Work Shoes
					Price: 25 coins
					If skipped: Work comfort decreases 
					and productivity drops.
					Alternative: Repair old shoes (12 coins)""",
		"has_alternative": true,
		"alt_name": "Repair shoes",
		"alt_price": 12,
		"label_buy": "Necessary",
		"label_alt": "Smart choice!",
		"image_node_name": "case2"
	},
	
	{
		"title": "Case 3: Midnight Flash Sale",
		"item_name": "RGB Gaming Headphone",
		"main_price": 40,
		"desc": """Item: RGB Gaming Headphone
					Price: 40 Coins (50% OFF)
					If skipped: No impact,
					continue using old headphone.
					Alternative: None""",
		"has_alternative": false,
		"alt_name": "",
		"alt_price": 0,
		"label_buy": "Impulsive purchase",
		"label_alt": "Smart choice!",
		"image_node_name": "case3"
	},
	
	{
		"title": "Case 4: Tomorrow's Lunch",
		"item_name": "Junk Food Near Office",
		"main_price": 15,
		"desc": """Item: Junk Food Near Office
					Price: 15 coins
					If skipped: You will be hungry 
					unless you cook.
					Alternative: Cook a simple meal 
					at home (6 coins)""",
		"has_alternative": true,
		"alt_name": "Home-made lunch",
		"alt_price": 6,
		"label_buy": "Optional",
		"label_alt": "Smart choice!",
		"image_node_name": "case4"
	},
]

@onready var lbl_budget = $CanvasLayer/"Budget label"
@onready var panel_mission = $CanvasLayer/MissionPanel
@onready var lbl_mission_title = %MissionTitle
@onready var lbl_item_desc = %ItemDescription

@onready var btn_buy = $CanvasLayer/MissionPanel/Buy
@onready var btn_alt = $CanvasLayer/MissionPanel/Alternative
@onready var btn_skip = $CanvasLayer/MissionPanel/Skip

@onready var panel_receipt = $CanvasLayer/ReceiptPanel

@onready var lbl_receipt_text = $CanvasLayer/ReceiptPanel/ReceiptText
@onready var lbl_narrator = $CanvasLayer/ReceiptPanel/NarratorLabel
@onready var btn_done = $CanvasLayer/ReceiptPanel/BtnDone

#Case
@onready var img_case1 = %case1
@onready var img_case2 = %case2
@onready var img_case3 = %case3
@onready var img_case4 = %case4

func _ready():
	panel_receipt.visible = false
	panel_mission.visible = true
	show_mission(current_mission_index)

func show_mission(index: int):
	if index < missions.size():
		var current_mission = missions[index]
		lbl_budget.text = "Budget: " + str(current_budget) + " Coins"
		lbl_mission_title.text = current_mission["title"]
		lbl_item_desc.text = current_mission["desc"]
		btn_buy.text = "Buy ($" + str(current_mission["main_price"]) + ")"
		
		# Logika Atur Visibilitas Gambar Secara Dinamis
		img_case1.visible = (current_mission["image_node_name"] == "case1")
		img_case2.visible = (current_mission["image_node_name"] == "case2")
		img_case3.visible = (current_mission["image_node_name"] == "case3")
		img_case4.visible = (current_mission["image_node_name"] == "case4")
		
		# Atur Tombol Alternatif
		if current_mission["has_alternative"]:
			btn_alt.visible = true
			btn_alt.text = "Alternative ($" + str(current_mission["alt_price"]) + ")"
		else:
			if current_mission["alt_name"] != "":
				btn_alt.visible = true
				btn_alt.text = "Alternative (Free)"
			else:
				btn_alt.visible = false
	else:
		show_final_receipt()
		
func next_mission():
	current_mission_index += 1
	show_mission(current_mission_index)

func _on_btn_done_pressed() -> void:
	if skipped_all_count == missions.size():
		get_tree().change_scene_to_file("res://scene/bad_ending.tscn")
	else:
		get_tree().change_scene_to_file("res://scene/congrats.tscn")

func _on_skip_pressed() -> void:
	var current_mission = missions[current_mission_index]
	receipt_items.append(current_mission["item_name"] + " (Skipped) \t$0 \t-> Saved Money!")
	skipped_all_count += 1 # Tambah hitungan setiap kali player menekan skip
	next_mission()

func _on_alternative_pressed() -> void:
	var current_mission = missions[current_mission_index]
	var price = current_mission["alt_price"]
	
	current_budget -= price
	total_spent += price
	
	var name_to_display = current_mission["alt_name"] if current_mission["alt_name"] != "" else "Free Alternative"
	receipt_items.append(name_to_display + " \t$" + str(price) + " \t-> " + current_mission["label_alt"])
	
	next_mission()

func _on_buy_pressed() -> void:
	var current_mission = missions[current_mission_index]
	var price = current_mission["main_price"]
	
	current_budget -= price
	total_spent += price
	
	receipt_items.append(current_mission["item_name"] + " \t$" + str(price) + " \t-> " + current_mission["label_buy"])
	
	if current_mission_index == 0 or current_mission_index == 2:
		total_savable += price
		
	next_mission()

# --- PANEL STRUK AKHIR ---
func show_final_receipt():
	panel_mission.visible = false
	panel_receipt.visible = true
	lbl_budget.text = "Budget: " + str(current_budget) + " Coins"
	
	# Matikan semua gambar saat struk muncul
	img_case1.visible = false
	img_case2.visible = false
	img_case3.visible = false
	img_case4.visible = false
	
	var receipt_string = "=== MONTHLY RECEIPT ===\n"
	for item in receipt_items:
		receipt_string += item + "\n"
	receipt_string += "---------------------------------------\n"
	receipt_string += "TOTAL SPENT: $" + str(total_spent) + "\n"
	
	lbl_receipt_text.text = receipt_string
	
	var advice_text = "Hmm... let's see where your money went.\n"
	
	# Kondisi baru: Memeriksa jika pemain melompati seluruh pilihan belanjaan
	if skipped_all_count == missions.size():
		advice_text += """Warning: You skipped absolutely everything. 
		While saving money is good, neglecting basic needs 
		like food and working tools is bad management. 
		Extreme stinginess can ruin your health and productivity in the long run!"""
	elif total_savable > 0:
		advice_text += "Analysis: If you avoided impulsive items like Headphone or Iced Coffee, 
		\nyou could save an extra $" + str(total_savable) + " Coins! 
		\nThat money is very valuable for your Emergency Fund."
	else:
		advice_text += """Awesome! You are a smart Receipt Detective. 
		You avoided impulse traps and prioritized needs perfectly!"""
		
	lbl_narrator.text = advice_text
