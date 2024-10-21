extends Node

signal RunDialogue(npcResource : NPC, dialogueResource : Dialogue, frameDelay : bool)

var dialogueScene : PackedScene = preload("res://Scenes/UI/Dialogue/DialogueUI.tscn")
var activeDialogue : DialogueUI = null

var queuedNpc : NPC = null
var queuedDialogue : Dialogue = null

func _ready() -> void:
	RunDialogue.connect(OnRunDialogue)

#func _process(_delta: float) -> void:
	#print("%s, %s" % [queuedNpc, queuedDialogue])
	
	#if queuedDialogue:
		#ExecuteDialogue(queuedNpc, queuedDialogue)
		#queuedNpc = null
		#queuedDialogue = null

func OnRunDialogue(npcResource : NPC, dialogueResource : Dialogue, frameDelay : bool = false) -> void: # When dialogue is started by an NPC	
	if queuedDialogue or activeDialogue != null:
		if frameDelay:
			queuedNpc = npcResource
			queuedDialogue = dialogueResource
			
			var timer : Timer = CreateTimer(0.05)
			timer.timeout.connect(ExecuteDialogue.bind(queuedNpc, queuedDialogue))
			timer.timeout.connect(timer.queue_free)
			
			return
		return
	
	else:
		ExecuteDialogue(npcResource, dialogueResource)
		return

func ExecuteDialogue(npcResource : NPC, dialogueResource : Dialogue) -> void:
	if activeDialogue == null:
		var playerHUD : CanvasLayer = get_tree().get_first_node_in_group("G_PlayerHUD")
		var dialogueUIInst : DialogueUI = dialogueScene.instantiate()
		
		dialogueUIInst.dialogueResource = dialogueResource
		dialogueUIInst.npcResource = npcResource
		
		playerHUD.add_child(dialogueUIInst)
		
		activeDialogue = dialogueUIInst
		
		queuedNpc = null
		queuedDialogue = null

func CreateTimer(waitTime : float) -> Timer:
	var newTimer : Timer = Timer.new()
	newTimer.one_shot = true
	newTimer.wait_time = waitTime
	newTimer.autostart = true
	
	add_child(newTimer)
	
	return newTimer
