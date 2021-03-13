extends Label

func _ready():
	pass # Replace with function body.

func InvestmentCounter(balance : float) -> void:
	var InvestmentCounter = 1000 - balance 
	text =  "Money until Investment: %.1f" % InvestmentCounter
	

func Checker(investor):
	if investor == "true":
		hide()
