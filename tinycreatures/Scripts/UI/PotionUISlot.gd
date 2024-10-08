extends HoverUI
class_name PotionUISlot

var potion : Potion

var selectSound : AudioStream = preload("res://Assets/Audio/Select.wav")
var denySound : AudioStream = preload("res://Assets/Audio/Deny.wav")

func _ready() -> void:
	%TextureRect.texture = potion.Sprite
	
	mouse_entered.connect(OnMouseEnter)
	mouse_exited.connect(OnMouseExit)

func OnMouseEnter() -> void:
	SignalBus.AlchemistShopHoverPotion.emit(potion)

func OnMouseExit() -> void:
	SignalBus.AlchemistShopStopHover.emit()

func _on_button_pressed() -> void:
	var player : PlayerController = get_tree().get_first_node_in_group("G_PlayerController")
	var creature : Creature = player.boundCreature
	
	if creature && Player.takeMoney(potion.potionCost):
		AudioManager.playSound(selectSound)
		
		potion.UsePotion(creature)
		
		AlchemistInventory.Inventory.remove_at(AlchemistInventory.Inventory.find(potion)) 
		queue_free()
	
	else: AudioManager.playSound(denySound)
