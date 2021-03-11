extends AudioStreamPlayer
var musicPreference = "unmuted"


func _ready():
	pass # Replace with function body.

func _on_MuteMusic_pressed():
	mute()
func _on_UnmuteMusic_pressed():
	unmute()

func mute():
	set_volume_db(-80)
	musicPreference = "muted"
func unmute():
	set_volume_db(0)
	musicPreference = "unmuted"
