extends Node2D

var children

func _ready() -> void:
	children = get_children().filter(isCPUParticle)
	
	for particle in children:
		particle.emitting = true

func _physics_process(_delta: float) -> void:
	var isPlaying : bool = false
	
	for particle in children:
		if particle.emitting == true:
			isPlaying = true
	
	if !isPlaying:
		queue_free()

func isCPUParticle(element) -> bool:
	if element is CPUParticles2D:
		return true
	
	return false
