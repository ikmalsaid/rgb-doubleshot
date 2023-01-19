extends CanvasLayer

var mute = false

func _ready():
	pass

func _on_StartWorld1_pressed():
	get_tree().change_scene("res://world/World1.tscn")

func _on_StartWorld2_pressed():
	get_tree().change_scene("res://world/World2.tscn")

func _on_StartWorld3_pressed():
	get_tree().change_scene("res://world/World3.tscn")

func _on_Sounds_pressed():
	if mute == true:
		mute = false
		$Sounds.text = "Sounds: ON"
	else:
		$Sounds.text = "Sounds: OFF"
	

func _on_Tutorial_pressed():
	get_tree().change_scene("res://world/Tutorial.tscn")
