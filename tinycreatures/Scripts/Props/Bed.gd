extends Area2D
class_name Bed

func _ready() -> void:
	pass

func OnInteract() -> void:
	SignalBus.Sleep.emit()
