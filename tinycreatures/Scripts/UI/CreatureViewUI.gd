extends Control

@export var creature : Creature

var selectSound : AudioStream = preload("res://Assets/Audio/Select.wav")

func _on_close_button_pressed() -> void:
	AudioManager.playSound(selectSound)
	queue_free()

func _ready() -> void:
	%BloodNumber.value = creature.Blood
	%PhlegmNumber.value = creature.Phlegm
	%YellowBileNumber.value = creature.YellowBile
	%BlackBileNumber.value = creature.BlackBile
	
	%CreatureName.text = creature.Name
