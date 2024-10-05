extends CanvasLayer

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/Monastery.tscn")
	AudioManager.playSound("res://Assets/Audio/Select.wav")
