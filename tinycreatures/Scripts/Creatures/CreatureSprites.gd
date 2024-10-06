extends Resource
class_name CreatureAesthetics

@export var Sprites : Array[Texture2D]
var Names : Array[String] = [
	"Luther",
	"Selene",
	"Vortigern,
	Elowen",
	"Thornevald",
	"Lilith",
	"Eryndor",
	"Ravelyn",
	"Alistair",
	"Morwenna",
	"Godric",
	"Seraphina",
	"Ysabeau",
	"Alaric",
	"Rowena",
	"Tiberius,
	Seraphion",
	"Elysande",
	"Edmund",
	"Vespera",
	"Melisande",
	"Sevrin",
	"Roderick",
	"Elspeth",
	"Magnus",
	"Arianwen",
	"Lucien",
	"Isolde",
	"Thalion",
	"Drucilla",
	"Valamir",
	"Ysadora",
	"Varick",
	"Araminta",
	"Leofric",
	"Ravelle",
	"Cassian",
	"Drystan",
	"Eirlys",
	"Bramwell",
	"Gwyneira",
	"Vandergrim",
	"Caedmon",
	"Ulric",
	"Aldric",
	"Morvyn",
	"Regulus",
	"Godfrey",
	"Osric",
	"Aveline"] 

func GetRandomSprite() -> Texture2D:
	return Sprites[randi_range(0, Sprites.size() - 1)]

func GetRandomName() -> String:
	return Names[randi_range(0, Names.size() - 1)]
