extends Resource
class_name UpgradeData

@export var id: String           # ID để lưu vào file (ví dụ: "might")
@export var display_name: String # Tên hiển thị (Might)
@export var icon: Texture2D      # Icon của chỉ số
@export var description: String  # Mô tả tác dụng
@export var base_price: int = 500
@export var price_step: int = 200 # Mỗi cấp tăng thêm bao nhiêu tiền
@export var max_level: int = 5
