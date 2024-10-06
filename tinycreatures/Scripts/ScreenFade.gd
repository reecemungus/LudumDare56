extends CanvasModulate
class_name ScreenFade

func _ready() -> void:
	SignalBus.FadeIn.connect(FadeIn)
	SignalBus.Sleep.connect(OnPlayerSlept)
	
	#if OS.has_feature("editor"):
		#visible = false

func OnPlayerSlept() -> void:
	%AnimationPlayer.current_animation = "SleepFade"
	AudioManager.playSound("res://Assets/Audio/Sleep.wav")

func SleepFadeEnd() -> void:
	SignalBus.OnSleep.emit()
	FadeIn()

func FadeIn() -> void:
	%AnimationPlayer.current_animation = "FadeIn"

func FreezePlayer(input : bool = false) -> void:
	SignalBus.FreezePlayer.emit(input)
