extends Label

func update_wallet(balance : float) -> void:
	set_autowrap(true)
	text =  "%.1f" % balance
