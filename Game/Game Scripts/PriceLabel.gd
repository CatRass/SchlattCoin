extends Label

func update_price(price : float) -> void:
	text = "Current Exchange rate: %.1f" % price
	print("Price changed to:", price)
