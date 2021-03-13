extends Label

var minigame = 0

func _ready():
	update_minigame(minigame)

func update_minigame(minigame: int) -> void:
	text = "Coins mined: %.0f" % minigame

func _on_Button_pressed():
	minigame = minigame + 1
	update_minigame(minigame)



