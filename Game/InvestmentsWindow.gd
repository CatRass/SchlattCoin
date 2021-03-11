extends WindowDialog

func _ready():
	get_close_button()
	set_title("Investo-tron") 


func _on_Investments_pressed():
	popup()
	set_resizable(false)

func _on_Close_Button_pressed():
	hide()

