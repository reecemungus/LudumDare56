extends Node

var Inventory : Array[Potion]
var restockCount : int = 8

func _init() -> void:
	RestockShop()
	
	SignalBus.OnSleep.connect(RestockShop)

func RestockShop() -> void:
	for i in range(Inventory.size()):
		Inventory.remove_at(0)
	
	for i in range(restockCount):
		var newPotion = Potion.new()
		Inventory.insert(i, newPotion)
