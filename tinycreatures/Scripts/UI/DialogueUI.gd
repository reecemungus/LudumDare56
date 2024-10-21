extends Control
class_name DialogueUI

@export var dialogueResource : Dialogue
@export var npcResource : NPC

@onready var dialogueTextInstance : Label = get_node("./TextContainer/MarginContainer/DialogueText")
@onready var dialogueButtonsInstance : VBoxContainer = get_node("./TextContainer/MarginContainer/DialogueButtons")

@onready var nameLabel : Label = get_node("./NameContainer/NameLabel")
@onready var textTimer : Timer = get_node("./TextTimer")

var currentTextBlock : String = "null"
var textBlockValue : int = 0
var maxSteps : int 

func _ready() -> void:
	maxSteps = dialogueResource.dialogue.size()
	
	%NameLabel.text = npcResource.Name
	
	dialogueTextInstance.text = dialogueResource.dialogue[textBlockValue]
	
	var acceptButton : Button = dialogueButtonsInstance.get_node("./Accept")
	acceptButton.pressed.connect(OnAcceptButton)
	
	var declineButton : Button = dialogueButtonsInstance.get_node("./Decline")
	declineButton.pressed.connect(queue_free)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact"):
		AdvanceText()

func _on_text_timer_timeout() -> void:
	if !dialogueTextInstance:
		return
	
	if dialogueTextInstance.visible_ratio < 1.0:
		dialogueTextInstance.visible_characters += 1
		
		AudioManager.playSound(npcResource.dialogueSounds[randi_range(0, npcResource.dialogueSounds.size()) - 1])

func AdvanceText() -> void: ## Move forward with dialogue, called on Input
	if dialogueTextInstance.visible_ratio < 1: # If dialogue block isn't finished
		dialogueTextInstance.visible_ratio = 1 # Finish dialogue
		return
		
	if (dialogueTextInstance.visible_ratio == 1) && (textBlockValue < maxSteps - 1): # If there are more blocks to go through
		textBlockValue += 1
		
		dialogueTextInstance.visible_ratio = 0.0 # Restart text progress
		dialogueTextInstance.text = dialogueResource.dialogue[textBlockValue]
		return
	
	elif dialogueResource.nextScene:
		dialogueTextInstance.visible = false
		dialogueButtonsInstance.visible = true
		return
	
	else:
		queue_free()

func OnAcceptButton() -> void:
	if dialogueResource.nextScene:
		var player : PlayerController = get_tree().get_first_node_in_group("G_PlayerController")
		
		var nextScene : DialogueScene = dialogueResource.nextScene.instantiate()
		nextScene.npc = npcResource
		
		player.add_child(nextScene)
	
	queue_free()
