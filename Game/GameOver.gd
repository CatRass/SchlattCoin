extends Node2D

var balance = 10
var coin = 0
var price = 11

# Called when the node enters the scene tree for the first time.
func _ready():
	save_level()


func save_level():
	var save_file = File.new()
	save_file.open("user://savefile.save", File.WRITE)
	save_file.store_line(str(balance))
	save_file.store_line(str(coin))
	save_file.store_line(str(price))
	save_file.close()
