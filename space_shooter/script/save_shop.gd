extends Node2D
const SAVE_FILE_PATH = "user://menu_shop_save.dat"
var diamond : int  =100000
var upgrades_levels: Dictionary = {
	"might": 0,
	"start_gold": 0
}
var base_stats_resource: stats = preload("res://resouces/player/weapon_stat/perminant_stats.tres")
var stat_vinh_vien : stats
func _ready() -> void:
	if base_stats_resource != null:
		stat_vinh_vien = base_stats_resource.duplicate()
	else:
		stat_vinh_vien = stats.new()
	diamond = 1000000
	# Khi vừa bật game lên, lập tức đi tìm file cũ để nạp lại tiền
	load_shop_data()
	print("=== SAVESHOP READY: upgrades_levels = ", upgrades_levels)
	print("=== SAVESHOP READY: diamond = ", diamond)

func get_upgrade_level(upgrade_id: String) -> int:
	if upgrades_levels.has(upgrade_id):
		return upgrades_levels[upgrade_id]
	return 0



func save_shop_data():
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	if file:
		var data = {
			"diamond": diamond,
			"upgrades_levels": upgrades_levels
		}
		file.store_var(data) # Ghi dữ liệu vào file
		file.close()
		print("--- SAVE SYSTEM: Đã lưu số vàng hiện tại là: ", diamond)

func load_shop_data():
	# Nếu người chơi mới chơi lần đầu, chưa có file save thì giữ nguyên 10000
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		print("--- SAVE SYSTEM: Chưa có file save cũ, dùng vàng mặc định.")
		return
		
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	if file:
		var data = file.get_var() # Đọc dữ liệu từ file ra biến data
		file.close()
		
		# Nạp số vàng cũ vào biến toàn cục
		if data:
			if data.has("diamond"):
				diamond = data["diamond"]
			if data.has("upgrades_levels"): # <--- Tải lại cấp độ cũ đã mua
				upgrades_levels = data["upgrades_levels"]
			print("--- SAVE SYSTEM: Tải dữ liệu thành công! Kim cương hiện có: ", diamond)
func reset_stat_vinh_vien():
	stat_vinh_vien = base_stats_resource.duplicate()
