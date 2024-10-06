extends Area2D

### INFO
## Script to pass Interaction from area to parent

@onready var parent : CreatureController = get_node("..")

func OnInteract() -> void:
	parent.OnInteract()

func OnDrag() -> void:
	parent.OnDrag()
