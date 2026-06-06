extends Button

# Taruh posisi awal sprite pas pertama kali game jalan
var start_position: Vector2

# Jarak maksimal gambar boleh bergeser (dalam pixel)
@export var max_offset: float = 30.0

# Kecepatan layer (makin besar angkanya, makin sensitif sama mouse)
# Layer jauh kasih angka kecil (misal 0.2), layer dekat kasih angka besar (misal 0.8)
@export var parallax_factor: float = 0.5 

func _ready():
	# Simpan posisi awal supaya gambarnya gak melosot ke mana-mana
	start_position = position

func _process(delta):
	# Ambil ukuran layar/viewport game
	var center_screen = get_viewport_rect().size / 2
	
	# Hitung seberapa jauh kursor mouse dari tengah layar (nilainya antara -1 sampai 1)
	var mouse_offset = (get_viewport().get_mouse_position() - center_screen) / center_screen
	
	# Hitung posisi target baru berdasarkan input mouse tadi
	var target_pos = start_position + (mouse_offset * max_offset * parallax_factor)
	
	# Gerakkan sprite ke posisi target secara smooth (lerp)
	position = position.lerp(target_pos, 5.0 * delta)
