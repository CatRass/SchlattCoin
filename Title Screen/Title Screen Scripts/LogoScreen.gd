extends Control


func _ready():
	print("Made by Chonk Gang Games Studio")
	print("-------------------------------")


func _on_Timer_timeout():
	get_tree().change_scene("res://Title Screen/title_screen.tscn")



func _on_SongTimer_timeout():
	get_node("Title").play()
