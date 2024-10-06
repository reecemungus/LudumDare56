extends Node

### Plant Growth ###

enum GrowthStage {SEED = 0, SPROUT = 1, GROWN = 2}
var GrowthPoints : int = 5

var dailyGrowth : int = 5

### NPCs ###

enum NPCID {FARMER, ALCHEMIST, KNIGHT, KING}

### Potions ###

enum PotionType {HOLY, BLOOD, PHLEGM, YELLOWBILE, BLACKBILE, RANDOM}

var potionSprites : Array[Texture2D] = [
load("res://Assets/Potions/Holy.png"), 
load("res://Assets/Potions/Blood.png"), 
load("res://Assets/Potions/Phlegm.png"), 
load("res://Assets/Potions/YellowBile.png"),
load("res://Assets/Potions/BlackBile.png"),
load("res://Assets/Potions/Random.png")]

const  potionCostMult : float = 5
