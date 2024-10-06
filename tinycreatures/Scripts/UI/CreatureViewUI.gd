extends Control

@export var creature : Creature

func _on_close_button_pressed() -> void:
	queue_free()

func _ready() -> void:
	%BloodNumber.value = creature.Blood
	%PhlegmNumber.value = creature.Phlegm
	%YellowBileNumber.value = creature.YellowBile
	%BlackBileNumber.value = creature.BlackBile
	
	%CreatureName.text = creature.Name
