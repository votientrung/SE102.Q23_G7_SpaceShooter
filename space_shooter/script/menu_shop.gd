# MenuShop.gd
extends Control

@export var list_upgrades: Array[UpgradeData] # Danh sách các file .tres nâng cấp
@export var slot_scene: PackedScene           # Kéo file upgrade_slot.tscn vào đây

# --- ĐƯỜNG DẪN UI KHUNG CHÍNH ---
@onready var grid_container = $window/ScrollContainer/GridContainer
@onready var gold_label = $window/GoldLeft

# --- ĐƯỜNG DẪN 3 NÚT CHỨC NĂNG CHÍNH ---
@onready var refund_button = $window/return      # Nút mũi tên quay lại/hoàn tiền bên trái
@onready var continue_button = $window/Continue    # Nút mũi tên tiếp tục bên phải
@onready var buy_button = $window/DetailPanel_uprate/buy_button # Nút dấu tích xác nhận mua

# --- ĐƯỜNG DẪN CHỮ HIỂN THỊ CHI TIẾT BÊN PHẢI ---
@onready var detail_panel = $window/DetailPanel_uprate
@onready var detail_name = $window/DetailPanel_uprate/VBoxContainer2/name
@onready var detail_desc = $window/DetailPanel_uprate/VBoxContainer2/Description
@onready var detail_price = $window/DetailPanel_uprate/VBoxContainer2/Price

# Biến lưu trữ món nâng cấp đang được người chơi chọn xem
var selected_upgrade: UpgradeData = null

func _ready() -> void:
	SaveShop.diamond = 100000000
	# 1. Ẩn bảng chi tiết bên phải đi khi mới mở shop (vì chưa chọn món nào)
	detail_panel.hide()
	
	# 2. Sinh ra các ô nâng cấp dựa vào danh sách cấu trúc Resource
	spawn_all_slots()
	update_gold_ui()
	# 3. Kết nối các nút bấm chức năng (TextureRect) với các hàm xử lý bên dưới
	refund_button.gui_input.connect(_on_refund_clicked)
	continue_button.gui_input.connect(_on_continue_clicked)
	buy_button.gui_input.connect(_on_buy_clicked)

# Hàm tạo vòng lặp tự động rải các ô nâng cấp vào GridContainer
func spawn_all_slots():
	# Xóa các ô nháp cũ trong Grid để tránh trùng lặp
	for child in grid_container.get_children():
		child.queue_free()
		
	for upgrade in list_upgrades:
		var slot_instance = slot_scene.instantiate()
		grid_container.add_child(slot_instance)
		
		# Nạp dữ liệu vào ô
		slot_instance.setup_slot(upgrade)
		
		# Lắng nghe xem khi nào ô này bị click thì gọi hàm hiển thị thông tin chi tiết
		slot_instance.slot_clicked.connect(_on_slot_selected)

# Hàm chạy khi một ô nâng cấp bất kỳ được click
func _on_slot_selected(upgrade_data: UpgradeData):
	selected_upgrade = upgrade_data
	
	# Hiện bảng thông tin chi tiết lên
	detail_panel.show()
	
	# Đổ chữ vào bảng chi tiết bên phải
	detail_name.text = upgrade_data.display_name
	detail_desc.text = upgrade_data.description
	detail_price.text = "Giá: " + str(upgrade_data.base_price)

# --- KHU VỰC BẤM NÚT CHỨC NĂNG ---

# 1. Khi bấm vào nút Hoàn Tiền (Mũi tên xoay ngược bên trái)
func _on_refund_clicked(event: InputEvent):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Nút HOÀN TIỀN đã được bấm!")
		# Logic trừ/cộng tiền sẽ viết ở đây sau khi kết nối Save dữ liệu

func display_detail(upgrade: UpgradeData):
	selected_upgrade = upgrade
	if upgrade == null:
		detail_panel.hide()
		return
		
	detail_panel.show()
	var lv = SaveShop.get_upgrade_level(upgrade.id)
	var is_maxed = lv >= upgrade.max_level
	var price = upgrade.base_price + (lv * upgrade.price_step)
	
	detail_name.text = upgrade.display_name
	detail_desc.text = upgrade.description
	
	if is_maxed:
		detail_price.text = "MAX LEVEL"
		buy_button.modulate = Color(0.3, 0.3, 0.3) # Làm tối hẳn nút khi không mua được nữa
	else:
		detail_price.text = "Price: " + str(price)
		# Làm sáng nút nếu đủ tiền, mờ nút nếu thiếu tiền
		buy_button.modulate = Color(1, 1, 1) if SaveShop.diamond >= price else Color(0.5, 0.5, 0.5)


# 2. Khi bấm vào nút Xác Nhận Mua (Dấu tích xanh)
func _on_buy_clicked(event: InputEvent):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if selected_upgrade != null:
			var upgrade_id = selected_upgrade.id
			var current_level = SaveShop.get_upgrade_level(upgrade_id)
			var price = selected_upgrade.base_price  + (current_level * selected_upgrade.price_step)
			if current_level >= selected_upgrade.max_level:
				print("Món này đã đạt cấp độ tối đa (MAX), không thể mua thêm!")
				return
			# Kiểm tra xem ví tiền global_gold có đủ trả không
			if SaveShop.diamond >= price:
				
				# 1. TRỪ TIỀN trực tiếp vào biến toàn cục của SaveShop
				SaveShop.diamond -= price
				SaveShop.upgrades_levels[upgrade_id] = current_level + 1
				update_gold_ui()
				print("Mua thành công! Số tiền còn lại trong ví: ", SaveShop.diamond)
				print("Mua thành công ", selected_upgrade.display_name, "! Cấp độ mới: ", SaveShop.upgrades_levels[upgrade_id])
				spawn_all_slots()
				_on_slot_selected(selected_upgrade)
				# 2. Cập nhật con số mới trừ này lên màn hình UI liền
				SaveShop.save_shop_data()
			else:
				print("Không đủ vàng trong Menu Shop để mua món này!")

# 3. Khi bấm vào nút Tiếp Tục (Mũi tên tiến bên phải)
func _on_continue_clicked(event: InputEvent):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Nút TIẾP TỤC đã được bấm! Chuẩn bị chuyển cảnh game...")
		get_tree().change_scene_to_file("res://scenes/gameplay.tscn")



func update_gold_ui():
	if gold_label:
		gold_label.text = str(SaveShop.diamond)


func _on_return_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		for upgrade in list_upgrades:
			var lv = SaveShop.get_upgrade_level(upgrade.id)
			if lv > 0:
				# Công thức tính trả lại toàn bộ số vàng đã đầu tư vào nhánh này
				var total = (float(lv)/2.0) * (2*upgrade.base_price + (lv-1)*upgrade.price_step)
				SaveShop.diamond += int(total)
		
		SaveShop.upgrades_levels.clear() # Xóa sạch các cấp độ đã mua
		#SaveShop.calculate_permanent_stats() # Reset chỉ số vĩnh viễn về mặc định
		SaveShop.save_shop_data() # Lưu lại file trắng lên máy
		
		# Reset giao diện cửa hàng
		update_gold_ui()
		spawn_all_slots()
		display_detail(null)
		print("Đã hoàn lại toàn bộ tiền nâng cấp!")
