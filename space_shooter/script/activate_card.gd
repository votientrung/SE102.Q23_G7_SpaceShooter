extends card
class_name  activate_card
func apply_card(player):
	CardManager.add_card(self)
func use_card(player):
	print("dung card nay")
