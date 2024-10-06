extends Node

@export var npc : NPC

func _ready() -> void:
	%Sprite.texture = npc.Sprite

func OnInteract() -> void:
	var player : PlayerController = get_tree().get_first_node_in_group("G_PlayerController")
	var playerHUD : CanvasLayer = get_tree().get_first_node_in_group("G_PlayerHUD")
	
	if npc.ShopkeeperScene:
		if npc.NPCType == Game.NPCID.FARMER && player.boundCreature == null:
			var unavalableScene = npc.UnavailableScene.instantiate()
			playerHUD.add_child(unavalableScene)
			return
		
		var scene = npc.ShopkeeperScene.instantiate()
		playerHUD.add_child(scene)
