extends Label

func bought_price(price : float) -> void:
	var boughtPrice = price
	text = "Last bought at: %.1f" % boughtPrice
