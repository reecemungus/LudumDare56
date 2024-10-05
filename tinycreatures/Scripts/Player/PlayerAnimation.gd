extends AnimationTree
class_name PlayerAnimation

@onready var player : PlayerController = get_tree().get_first_node_in_group("G_PlayerController")

var blipTarget : float = 0.0
var blipLocation : float = 0.0
const blipSpeed : float = 0.05

func _physics_process(_delta: float) -> void:
	if player.velocity != Vector2.ZERO:
		blipTarget = 1.0
	else:
		blipTarget = 0.0
	
	blipLocation = move_toward(blipLocation, blipTarget, blipSpeed)
	set("parameters/blend_position", blipLocation)
