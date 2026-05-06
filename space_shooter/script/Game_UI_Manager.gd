extends CanvasLayer

var ui_stack: Array = []

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func push_ui(ui: Control):
	if ui_stack.has(ui):
		return
	
	ui_stack.append(ui)
	ui.show()
	
	get_tree().paused = true

func pop_ui():
	if ui_stack.is_empty():
		return
	
	var top_ui = ui_stack.pop_back()
	top_ui.hide()
	
	if ui_stack.is_empty():
		get_tree().paused = false
