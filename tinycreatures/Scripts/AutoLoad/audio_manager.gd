extends Node

### INFO
## Global class handling the creation and destruction of audio assets at runtime

func playSoundAtLocation(globalLocation : Vector2, sound : String, pitchVariation : float = 0.2) -> void:
	var newSound : AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	newSound.bus = "SFX"
	newSound.stream = load(sound)
	
	add_child(newSound)
	newSound.global_position = globalLocation
	
	newSound.pitch_scale = randf_range((1 - pitchVariation), (1 + pitchVariation))
	
	newSound.playing = true
	newSound.finished.connect(newSound.queue_free)

func playSound(sound : String, pitchVariation : float = 0.2) -> void:
	var newSound : AudioStreamPlayer = AudioStreamPlayer.new()
	newSound.bus = "SFX"
	newSound.stream = load(sound)
	
	add_child(newSound)
	
	newSound.pitch_scale = randf_range((1 - pitchVariation), (1 + pitchVariation))
	
	newSound.playing = true
	newSound.finished.connect(newSound.queue_free)
