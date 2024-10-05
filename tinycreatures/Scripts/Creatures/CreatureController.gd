extends Area2D
class_name CreatureController

### INFO 
## Class to control a creature scene in game, owns a creature as a child

var creatureRes : Creature = Creature.new()

func _ready() -> void:
	ResourceSaver.save(creatureRes, "res://Scenes/Creatures/testCreature.tres")
	
	SignalBus.CreatureUpdateSprite.connect(UpdateSprite)

func UpdateSprite() -> void:
	match creatureRes.GrowthStage:
		Game.GrowthStage.SEED:
			%CreatureSprite.texture = creatureRes.SeedSprite
		Game.GrowthStage.SPROUT:
			%CreatureSprite.texture = creatureRes.SproutSrite
		Game.GrowthStage.GROWN:
			%CreatureSprite.texture = creatureRes.GrownSprite

func OnSleep() -> void:
	pass

func OnInteract() -> void:
	print("YAY")
