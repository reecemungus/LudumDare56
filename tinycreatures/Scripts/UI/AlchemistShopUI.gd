extends Control

var LocalInventory : Array[PotionUISlot]

func _ready() -> void:
	SignalBus.AlchemistShopHoverPotion.connect(UpdatePotionLabel)
	SignalBus.AlchemistShopStopHover.connect(ClearPotionLabel)
	
	UpdateCatalog()

func UpdateCatalog() -> void:
	for i in range(LocalInventory.size()):
		LocalInventory[i].queue_free()
	
	for i in range(AlchemistInventory.Inventory.size()):
		var potionUISlot = preload("res://Scenes/UI/PotionUISlot.tscn").instantiate()
		potionUISlot.potion = AlchemistInventory.Inventory[i]
		
		%GridContainer.add_child(potionUISlot)

func UpdatePotionLabel(potion : Potion) -> void:
	var string : String = "%s Potion, cost of %s Gold Pieces" % [potion.potionName, potion.potionCost]
	%PotionInfo.text = string

func ClearPotionLabel() -> void:
	%PotionInfo.text = "Thank You for your custom"

func _on_close_button_pressed() -> void:
	queue_free()
