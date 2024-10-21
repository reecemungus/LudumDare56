extends DialogueScene
class_name KnightScene

func _ready() -> void:
	if Player.takeMoney(5):
		var player : PlayerController = get_tree().get_first_node_in_group("G_PlayerController")
		var level : Node2D = get_tree().get_first_node_in_group("G_Level")
		
		var sprout : CreatureController = preload("res://Scenes/Creatures/CreatureCharacter.tscn").instantiate()
		level.add_child(sprout)
		
		sprout.global_position = player.global_position
		
		queue_free()
		return
	else:
		var failDialogue : Dialogue = npc.failDialogues[randi_range(0, npc.failDialogues.size() - 1)]
		DialogueManager.RunDialogue.emit(npc, failDialogue, true)
		queue_free()
		return
