extends Node2D
const SAVE_FILE_PATH = "user://menu_shop_save.dat"
var diamond : int  =0
var upgrades_levels: Dictionary = {
	"might": 0,
	"gold": 0,
	"mana" :0,
	"armor" :0,
	"weapon lv" :0
}
var base_stats_resource: stats = preload("res://resouces/player/weapon_stat/perminant_stats.tres")
var stat_vinh_vien : stats
func _ready() -> void:
	if base_stats_resource != null:
		stat_vinh_vien = base_stats_resource.duplicate()
	else:
		stat_vinh_vien = stats.new()
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
		# Chuyển Dictionary thành chuỗi chữ viết đọc được (JSON)
		var json_string = JSON.stringify(data)
		file.store_line(json_string)
		file.close()
		print("--- SAVE SYSTEM: Đã lưu dữ liệu dạng Text dễ sửa!")

func load_shop_data():
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		return
		
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	if file:
		var json_string = file.get_line()
		file.close()
		
		var json = JSON.new()
		var error = json.parse(json_string)
		if error == OK:
			var data = json.get_data()
			if data.has("diamond"): diamond = int(data["diamond"])
			if data.has("upgrades_levels"): upgrades_levels = data["upgrades_levels"]
			print("--- SAVE SYSTEM: Tải dữ liệu JSON thành công!")
			
func reset_stat_vinh_vien():
	stat_vinh_vien = base_stats_resource.duplicate()
