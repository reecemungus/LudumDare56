extends Node

@export var npc : NPC

var activeUI

func _ready() -> void:
	%Sprite.texture = npc.Sprite

func OnInteract() -> void:
	var player : PlayerController = get_tree().get_first_node_in_group("G_PlayerController")
	var playerHUD : CanvasLayer = get_tree().get_first_node_in_group("G_PlayerHUD")
	
	if npc.ShopkeeperScene:
		if npc.NPCType == Game.NPCID.KNIGHT:
			if !activeUI:
				activeUI = npc.ShopkeeperScene.instantiate()
				playerHUD.add_child(activeUI)
				return
		
		if player.boundCreature == null or player.boundCreature.GrowthStage != Game.GrowthStage.GROWN:
			if !activeUI:
				activeUI = npc.UnavailableScene.instantiate()
				playerHUD.add_child(activeUI)
				return
		
		if !activeUI:
			activeUI = npc.ShopkeeperScene.instantiate()
			playerHUD.add_child(activeUI)
			return
