extends Node

### INFO 
## Global Class handling all signals called at runtime

signal OnPlayerInteract(area : Area2D)
signal FreezePlayer(input : bool)

signal CreatureUpdateSprite

signal Sleep # Start sleep animations etc
signal OnSleep # Call sleep logic

signal FadeIn
signal FadeOut

var screenFadeScene := preload("res://Scenes/screen_fade.tscn")
var screenFade : ScreenFade

func _ready() -> void:
	get_window().min_size = Vector2(960, 540)
	
	var tempFade = screenFadeScene.instantiate()
	add_child(tempFade)
	
	screenFade = tempFade
	
	OnPlayerInteract.connect(InteractPassThrough)

func InteractPassThrough(area : Area2D) -> void: # Call interact function on area
	if area.has_method("OnInteract"):
		area.OnInteract()
