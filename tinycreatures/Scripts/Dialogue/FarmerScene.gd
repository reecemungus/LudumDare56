extends DialogueScene
class_name FarmerScene

var deathSound : AudioStream = preload("res://Assets/Audio/Death.wav")

func _ready() -> void:
	var player : PlayerController = get_tree().get_first_node_in_group("G_PlayerController")
	
	if player.boundCreature:
		Player.addMoney(player.boundCreature.CalculateValue())
		SignalBus.KillBoundCreature.emit()
		
		AudioManager.playSound(deathSound)
		
		SignalBus.OnPlayerReleaseCreature.emit()
		queue_free()
		return
	#else:
		#var turnawayDialogue = npc.noCreatureDialogues[randi_range(0, npc.noCreatureDialogues.size() - 1)]
		#DialogueManager.RunDialogue.emit(npc, turnawayDialogue, true)
