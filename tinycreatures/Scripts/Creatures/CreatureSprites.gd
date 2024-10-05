extends Resource
class_name CreatureSpriteArray

@export var Sprites : Array[Texture2D]

func GetRandomSprite() -> Texture2D:
	return Sprites[randi_range(0, Sprites.size() - 1)]
