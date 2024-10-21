extends DialogueScene

var shopScene : PackedScene = preload("res://Scenes/UI/AlchemistShopUI.tscn")

func _ready() -> void:
	var playerHud := get_tree().get_first_node_in_group("G_PlayerHUD")
	
	var shopInst = shopScene.instantiate()
	playerHud.add_child(shopInst)
