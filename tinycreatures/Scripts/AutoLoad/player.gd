extends Node

var money : int = 25
var multiplier : float = 15.0

func addMoney(inMoney : int) -> void:
	money = money + inMoney
	SignalBus.UpdateGoldCount.emit()

func takeMoney(outMoney : int) -> bool:
	var sumMoney : int = money - outMoney
	
	if sumMoney >= 0:
		money = sumMoney
		SignalBus.UpdateGoldCount.emit()
		return true
	
	else: return false
