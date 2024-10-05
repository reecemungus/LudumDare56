extends Control
class_name HoverUI

### INFO
## Class to make UI Elements grow in size when they are hovered

@export var hoverSize : float = 1.1
@export var hoverSpeed : float = 0.1

var targetSize : Vector2 = Vector2.ONE

func _ready() -> void:
	pivot_offset = Vector2(size.x / 2, size.y / 2)

func _physics_process(_delta: float) -> void:
	scale = lerp(scale, targetSize, hoverSpeed)

func _on_mouse_entered() -> void:
	targetSize = Vector2(hoverSize, hoverSize)
	AudioManager.playSound("res://Assets/Audio/Hover.wav")

func _on_mouse_exited() -> void:
	targetSize = Vector2.ONE

func _on_resized() -> void:
	pivot_offset = Vector2(size.x / 2, size.y / 2)
