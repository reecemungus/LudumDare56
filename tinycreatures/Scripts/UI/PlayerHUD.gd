extends Control
class_name PlayerHUD

func _ready() -> void:
	SignalBus.UpdateGoldCount.connect(UpdateGold)

func UpdateGold() -> void:
	%GoldCount.text = str(Player.money)
