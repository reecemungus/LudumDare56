extends Resource
class_name NPC

@export_group("CharacterInfo")
@export var Sprite : Texture2D
@export var NPCType : Game.NPCID

@export_group("Shop")
@export var ShopkeeperScene : PackedScene = null
@export var UnavailableScene : PackedScene = null
