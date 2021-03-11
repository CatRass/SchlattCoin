extends Label


func sold_price(price : float) -> void:
	var soldPrice = price
	text = "Last sold at: %.1f" % soldPrice

