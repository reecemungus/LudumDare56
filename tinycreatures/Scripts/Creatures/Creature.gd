extends Resource
class_name Creature

### INFO 
## Class describing a "Creature"

@export var Name : String = "RealBoy"

@export var SeedSprite : Texture2D = load("res://Assets/CharacterSprites/Creatures/Seedling.png")
@export var SproutSrite : Texture2D = load("res://Assets/CharacterSprites/Creatures/Sproutling.png")
@export var GrownSprite : Texture2D

@export var GrowthStage : Game.GrowthStage = Game.GrowthStage.SEED
@export var GrowthSpeed : int 

var growthPoints : int = 5 # When this hits 0, the GrowthStage will Increment

@export var Blood : float = 0.0 # heart, red
@export var Phlegm : float = 0.0 # brain, blue
@export var YellowBile : float = 0.0 # liver, yellow
@export var BlackBile : float = 0.0 # spleen, black

@export var CreatureValue : int

func _init() -> void:
	var creatureAes : CreatureAesthetics = load("res://Scripts/Creatures/CreatureSprites.tres")
	GrownSprite = creatureAes.GetRandomSprite()
	
	Name = creatureAes.GetRandomName()
	
	AssignInitialStats()
	CalculateValue()
	
	SignalBus.OnSleep.connect(OnSleep)

func AssignInitialStats() -> void:
	var mult := Player.multiplier
	
	Blood = randf_range(mult / 4, mult)
	Phlegm = randf_range(mult / 4, mult)
	YellowBile = randf_range(mult / 4, mult)
	BlackBile = randf_range(mult / 4, mult)
	
	GrowthSpeed = randi_range(1, 3)

func OnSleep() -> void:
	if GrowthStage == Game.GrowthStage.GROWN: # If is fully grown, exit
		return
	
	growthPoints -= GrowthSpeed
	
	if growthPoints <= 0:
		growthPoints = Game.GrowthPoints
		AdvanceGrowthStage()
		SignalBus.CreatureUpdateSprite.emit()

func AdvanceGrowthStage() -> void:
	match GrowthStage:
		Game.GrowthStage.SEED:
			GrowthStage = Game.GrowthStage.SPROUT
		Game.GrowthStage.SPROUT:
			GrowthStage = Game.GrowthStage.GROWN
		Game.GrowthStage.GROWN:
			pass

func CalculateValue() -> int:
	var tempVal : float = ((Blood + Phlegm + YellowBile + BlackBile) / 4)
	CreatureValue = floorf(tempVal)
	
	return CreatureValue
