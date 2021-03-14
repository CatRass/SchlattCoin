extends Control

func _ready():
	pass


func _on_NewGameButton_pressed():
	get_tree().change_scene("res://Game/game_UI.tscn")

func _on_OptionsButton_pressed():
	pass
	#get_tree().change_scene("res://Game/options_screen.tscn")

func _on_ExitButton_pressed():
	get_tree().quit()


func _on_ChangeLog_pressed():
	$ChangeLogWindow.show()
