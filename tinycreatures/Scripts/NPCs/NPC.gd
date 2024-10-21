extends Resource
class_name NPC

@export_group("CharacterInfo")
@export var Name : String
@export var Sprite : Texture2D
@export var dialogueSounds : Array[AudioStream]

@export_group("Dialogue")
@export var firstDialogue : Dialogue
@export var dialogues : Array[Dialogue]
@export var noCreatureDialogues : Array[Dialogue]
@export var ungrownCreatureDialogues : Array[Dialogue]
@export var failDialogues : Array[Dialogue]

@export var needsCreature : bool = true

@export var hasBeenMet : bool = false
