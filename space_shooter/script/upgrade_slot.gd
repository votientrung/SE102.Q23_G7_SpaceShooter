# upgrade_slot.gd
extends Button

# Định nghĩa tín hiệu (Signal) để báo cho Menu chính biết ô này vừa được click
signal slot_clicked(data: UpgradeData)

# Khai báo các đường dẫn đến Node con bên trong ô nâng cấp
@onready var texture_rect: TextureRect = $TextureRect2
@onready var name_label: Label = $name
@onready var level_container = $HBoxContainer
# Biến tạm để lưu dữ liệu Resource truyền vào
var my_data: UpgradeData
func _ready():
	# Xử lý hiệu ứng khi di chuột vào/ra bằng code (hoặc dùng Theme Overrides)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
# Hàm này dùng để nạp chữ và ảnh từ Resource lên giao diện ô Slot
func setup_slot(data: UpgradeData):
	my_data = data
	name_label.text = data.display_name
	texture_rect.texture = data.icon
	update_ui()
func update_ui():
	if not my_data: return
	
	# 1. Lấy cấp độ hiện tại từ Singleton SaveShop
	var current_lv = SaveShop.get_upgrade_level(my_data.id)
	
	# 2. Xóa các ô vuông cũ để vẽ mới
	for child in level_container.get_children():
		child.queue_free()
	
	# 3. Tạo các ô vuông nhỏ (pips) dựa trên max_level
	for i in range(my_data.max_level):
		var pip = ColorRect.new()
		
		# Thiết lập kích thước ô vuông nhỏ
		pip.custom_minimum_size = Vector2(12, 6) 
		
		# Tô màu: Vàng nếu đã mua, Xám nếu chưa
		if i < current_lv:
			pip.color = Color("ffcc00") # Màu Gold
		else:
			pip.color = Color("333333") # Màu Dark Gray
			
		level_container.add_child(pip)
	
	# 4. Hiệu ứng nếu đã đạt cấp tối đa
	if current_lv >= my_data.max_level:
		self.modulate = Color(1.1, 1.1, 1.1) # Làm ô sáng hơn

# Khi người dùng nhấn vào ô này
# Hiệu ứng Tween đơn giản khi di chuột
func _on_mouse_entered():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.05, 1.05), 0.1)

func _on_mouse_exited():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1)

# Hàm xử lý mặc định của Node Button khi được người chơi click vào
func _pressed() -> void:
	if my_data != null:
		# Phát tín hiệu đi kèm theo toàn bộ dữ liệu của món đồ này
		slot_clicked.emit(my_data)
		print("Đã click vào ô nâng cấp: ", my_data.display_name)
