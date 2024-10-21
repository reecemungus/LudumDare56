extends Node

@export var npc : NPC

func _ready() -> void:
	%Sprite.texture = npc.Sprite

func OnInteract() -> void:
	var dialogueToRun : Dialogue = null
	
	if !npc.hasBeenMet:
		DialogueManager.RunDialogue.emit(npc, npc.firstDialogue)
		npc.hasBeenMet = true
	else:
		if npc.needsCreature:
			var player : PlayerController = get_tree().get_first_node_in_group("G_PlayerController")
			
			if player.boundCreature:
				if player.boundCreature.GrowthStage == Game.GrowthStage.GROWN: 
					dialogueToRun = npc.dialogues[randi_range(0, npc.dialogues.size() - 1)]
					DialogueManager.RunDialogue.emit(npc, dialogueToRun)
					return
				else:
					dialogueToRun = npc.ungrownCreatureDialogues[randi_range(0, npc.ungrownCreatureDialogues.size() - 1)]
					DialogueManager.RunDialogue.emit(npc, dialogueToRun)
					return
			
			var turnawayDialogue : Dialogue = npc.noCreatureDialogues[randi_range(0, npc.noCreatureDialogues.size() - 1)]
			DialogueManager.RunDialogue.emit(npc, turnawayDialogue)
			return
		
		dialogueToRun = npc.dialogues[randi_range(0, npc.dialogues.size() - 1)]
		DialogueManager.RunDialogue.emit(npc, dialogueToRun)
		return
