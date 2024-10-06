extends Resource
class_name CreatureAesthetics

@export var Sprites : Array[Texture2D]
var Names 

func _init() -> void:
	var file_path = "res://Scripts/Creatures/Names.txt"
	var content = FileAccess.open(file_path, FileAccess.READ).get_as_text()
	
	Names = content.split("\n")
	
	for i in range(Names.size()):
		if Names[i] == "":
			Names.remove_at(i)

func GetRandomSprite() -> Texture2D:
	return Sprites[randi_range(0, Sprites.size() - 1)]

func GetRandomName() -> String:
	return Names[randi_range(0, Names.size() - 1)]
