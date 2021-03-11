extends Label

func update_coin(coin : int) -> void:
	set_autowrap(true)
	text = "%.0f" % coin
