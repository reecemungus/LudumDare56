extends Control

@onready var player : PlayerController = get_tree().get_first_node_in_group("G_PlayerController")
var creature : Creature

var deathSound : AudioStream = preload("res://Assets/Audio/Death.wav")

func _ready() -> void:
	creature = player.boundCreature
	
	var offer : String = "%s Gold Pieces" % creature.CalculateValue()
	%OfferedMoney.text = offer

func _on_accept_pressed() -> void:
	Player.addMoney(player.boundCreature.CalculateValue())
	SignalBus.KillBoundCreature.emit()
	
	AudioManager.playSound(deathSound)
	
	SignalBus.OnPlayerReleaseCreature.emit()
	queue_free()

func _on_decline_pressed() -> void:
	queue_free()
