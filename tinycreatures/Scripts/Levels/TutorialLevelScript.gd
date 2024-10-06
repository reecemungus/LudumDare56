extends Node2D

@export var text : Array[String]
var textSteps : int = 0
var maxSteps : int

func _ready() -> void:
	SignalBus.FadeIn.emit()
	maxSteps = text.size()
	
	%Label.text = text[textSteps]

func _input(event: InputEvent) -> void:
	if textSteps == maxSteps:
		get_tree().change_scene_to_file("res://Scenes/Levels/Monastery.tscn")
		return
	
	if event.is_action_pressed("Interact"):
		AdvanceText()

func AdvanceText() -> void:
	if %Label.visible_ratio < 1:
		%Label.visible_ratio = 1
		return
	
	if %Label.visible_ratio == 1:
		textSteps += 1
		
		if textSteps != maxSteps:
			
			%Label.visible_ratio = 0.0 
			%Label.text = text[textSteps]

func _on_timer_timeout() -> void:
	if %Label.visible_ratio < 1.0:
		%Label.visible_characters += 1
		AudioManager.playSound("res://Assets/Audio/Speak.wav", 0.5)
