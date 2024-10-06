extends AnimationTree
class_name CreatureAnimation

@onready var creature : CreatureController = get_node("..")

var blipTarget : float = 0.0
var blipLocation : float = 0.0
const blipSpeed : float = 0.05

func _physics_process(_delta: float) -> void:
	if creature.velocity != Vector2.ZERO:
		blipTarget = 1.0
	else:
		blipTarget = 0.0
	
	blipLocation = move_toward(blipLocation, blipTarget, blipSpeed)
	set("parameters/blend_position", blipLocation)
