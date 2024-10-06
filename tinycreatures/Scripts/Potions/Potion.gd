extends Resource
class_name Potion

@export var Sprite : Texture2D
@export var potionType : Game.PotionType

@export var potionName : String
@export var potionStrength : float
@export var potionCost : int

func _init() -> void:
	potionStrength = randf_range(10, 100)
	potionCost = potionStrength / Game.potionCostMult
	
	var pt = randi_range(0, 5)
	
	match pt:
		0:
			potionType = Game.PotionType.HOLY
			potionName = "Holy"
		1:
			potionType = Game.PotionType.BLOOD
			potionName = "Blood"
		2:
			potionType = Game.PotionType.PHLEGM
			potionName = "Phlegm"
		3:
			potionType = Game.PotionType.YELLOWBILE
			potionName = "Yellow Bile"
		4:
			potionType = Game.PotionType.BLACKBILE
			potionName = "Black Bile"
		5:
			potionType = Game.PotionType.RANDOM
			potionName = "Chum"
	
	Sprite = Game.potionSprites[pt]
	
	ResourceSaver.save(self, "res://Scenes/testPot.tres")

func UsePotion(creature : Creature) -> void:
	match potionType:
		Game.PotionType.HOLY:
			UseHoly(creature)
		Game.PotionType.BLOOD:
			UseBlood(creature)
		Game.PotionType.PHLEGM:
			UsePhlegm(creature)
		Game.PotionType.YELLOWBILE:
			UseYellowBile(creature)
		Game.PotionType.BLACKBILE:
			UseBlackBile(creature)
		Game.PotionType.RANDOM:
			UseRandom(creature)

func UseHoly(_creature : Creature) -> void:
	Player.multiplier += potionStrength * (Player.multiplier / 100)

func UseBlood(creature : Creature) -> void:
	creature.Blood += potionStrength * (Player.multiplier / 100)
	
	SignalBus.CreatureUpdateHumors.emit()

func UsePhlegm(creature : Creature) -> void:
	creature.Phlegm += potionStrength * (Player.multiplier / 100)
	
	SignalBus.CreatureUpdateHumors.emit()

func UseYellowBile(creature : Creature) -> void:
	creature.YellowBile += potionStrength * (Player.multiplier / 100)
	
	SignalBus.CreatureUpdateHumors.emit()

func UseBlackBile(creature : Creature) -> void:
	creature.BlackBile += potionStrength * (Player.multiplier / 100)
	
	SignalBus.CreatureUpdateHumors.emit()

func UseRandom(creature : Creature) -> void:
	creature.Blood += (potionStrength * (Player.multiplier / 100)) / randf_range(0 , 10)
	creature.Phlegm += (potionStrength * (Player.multiplier / 100)) / randf_range(0 , 10)
	creature.YellowBile += (potionStrength * (Player.multiplier / 100)) / randf_range(0 , 10)
	creature.BlackBile += (potionStrength * (Player.multiplier / 100)) / randf_range(0 , 10)
	
	SignalBus.CreatureUpdateHumors.emit()
