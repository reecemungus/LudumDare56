extends Node2D
class_name MonasteryLevelScript

func _ready() -> void:
	SignalBus.FadeIn.emit()
