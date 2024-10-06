extends Control

func _on_accept_pressed() -> void:
	var player : PlayerController = get_tree().get_first_node_in_group("G_PlayerController")
	
	if player.boundCreature && player.boundCreature.GrowthStage == Game.GrowthStage.GROWN:
		if player.boundCreature.Blood >= 95 && player.boundCreature.Phlegm >= 95 && player.boundCreature.YellowBile >= 95 && player.boundCreature.BlackBile >= 95:
			SignalBus.EndGame.emit()
	
	queue_free()

func _on_decline_pressed() -> void:
	queue_free()
