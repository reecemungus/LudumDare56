extends CanvasModulate
class_name ScreenFade

var sleepSound : AudioStream = preload("res://Assets/Audio/Sleep.wav")

func _ready() -> void:
	SignalBus.FadeIn.connect(FadeIn)
	SignalBus.FadeOut.connect(FadeOut)
	SignalBus.Sleep.connect(OnPlayerSlept)
	
	if OS.has_feature("editor"):
		visible = false

func OnPlayerSlept() -> void:
	%AnimationPlayer.current_animation = "SleepFade"
	AudioManager.playSound(sleepSound)

func SleepFadeEnd() -> void:
	SignalBus.OnSleep.emit()
	FadeIn()

func FadeIn() -> void:
	%AnimationPlayer.current_animation = "FadeIn"

func FreezePlayer(input : bool = false) -> void:
	SignalBus.FreezePlayer.emit(input)

func FadeOut() -> void:
	%AnimationPlayer.current_animation = "FadeOut"

func EndGame() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/EndingLevel.tscn")
