extends Label

func sold_price(price : float) -> void:
	var soldPrice : float = price
	text = "Last sold at: %.1f" % soldPrice
