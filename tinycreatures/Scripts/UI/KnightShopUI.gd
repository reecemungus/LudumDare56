extends Control

func _on_accept_pressed() -> void:
	var player : PlayerController = get_tree().get_first_node_in_group("G_PlayerController")
	var level : Node2D = get_tree().get_first_node_in_group("G_Level")
	
	var sprout : CreatureController = preload("res://Scenes/Creatures/CreatureCharacter.tscn").instantiate()
	level.add_child(sprout)
	
	sprout.global_position = player.global_position
	
	if Player.takeMoney(5):
		queue_free()

func _on_decline_pressed() -> void:
	queue_free()
