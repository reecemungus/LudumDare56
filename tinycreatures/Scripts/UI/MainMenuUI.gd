extends CanvasLayer

var selectSound : AudioStream = preload("res://Assets/Audio/Select.wav")

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/TutorialLevel.tscn")
	AudioManager.playSound(selectSound)
