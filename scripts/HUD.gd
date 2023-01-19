extends CanvasLayer

func _ready():
	pass


func _on_Quit_pressed():
	get_tree().change_scene("res://world/Title.tscn")


func _on_Reset_pressed():
	get_tree().reload_current_scene()
