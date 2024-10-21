@tool 
extends EditorScript

var characterDict : Dictionary = {
	"alchemist" : [],
	"farmer" : [],
	"king" : [],
	"knight" : []
}

var characters : Array[NPC] = [
	load("res://Scenes/Characters/Alchemist.tres"),
	load("res://Scenes/Characters/Farmer.tres"),
	load("res://Scenes/Characters/King.tres"),
	load("res://Scenes/Characters/Knight.tres")
	]

var dialogueFolders : Array[String] = [
	"res://Scenes/Characters/Dialogue/Alchemist",
	"res://Scenes/Characters/Dialogue/Farmer",
	"res://Scenes/Characters/Dialogue/King",
	"res://Scenes/Characters/Dialogue/Knight"
	]

var files 

func _run() -> void:
	for char in characters: # Clear old data
		char.firstDialogue = null
		char.dialogues.clear()
		char.noCreatureDialogues.clear()
		char.ungrownCreatureDialogues.clear()
		char.failDialogues.clear()
	
	for i in range(characters.size()):
		
		files = DirAccess.open(dialogueFolders[i]).get_files()
		
		for file in files:
			
			if file.contains("tscn") or file.contains("gd"):
				continue
			
			var targetPath : String = "null"
			
			if file.contains("intro"):
				targetPath = dialogueFolders[i] + "/" + file
				characters[i].firstDialogue = load(targetPath)
				continue
			
			if file.contains("dialogue"):
				targetPath = dialogueFolders[i] + "/" + file
				characters[i].dialogues.insert(0, load(targetPath))
				continue
			
			if file.contains("noCreature"):
				targetPath = dialogueFolders[i] + "/" + file
				characters[i].noCreatureDialogues.insert(0, load(targetPath))
				continue
			
			if file.contains("ungrownCreature"):
				targetPath = dialogueFolders[i] + "/" + file
				characters[i].ungrownCreatureDialogues.insert(0, load(targetPath))
				continue
			
			if file.contains("fail"):
				targetPath = dialogueFolders[i] + "/" + file 
				characters[i].failDialogues.insert(0, load(targetPath))
				continue
			
			#print("Adding %s to %s" % [file, targetPath])
		
		files.clear()
