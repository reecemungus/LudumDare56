extends CharacterBody2D
class_name PlayerController

### INFO
## Script managing player input 

const SPEED = 5000.0
const SLOWVAL = 500.0

var canMove : bool = true
var boundCreature : Creature

var footstepSound : AudioStream = preload("res://Assets/Audio/FootStep.wav")

func _ready() -> void:
	SignalBus.UpdateGoldCount.emit()
	
	SignalBus.FreezePlayer.connect(FreezePlayer)
	SignalBus.BindCreatureToPlayer.connect(BindCreature)
	SignalBus.OnPlayerReleaseCreature.connect(ClearBoundCreature)

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	
	if direction && canMove:
		velocity = direction * SPEED * delta
	else:
		## Constantly slow down
		
		velocity.x = move_toward(velocity.x, 0, SPEED / SLOWVAL)
		velocity.y = move_toward(velocity.y, 0, SPEED / SLOWVAL)
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if !canMove: return
	
	if event.is_action_pressed("Interact"):
		var area : Area2D = FindInput()
		if area: SignalBus.OnPlayerInteract.emit(area)
	if event.is_action_pressed("Drag"):
		if boundCreature == null:
			var area : Area2D = FindInput()
			if area: SignalBus.OnPlayerDrag.emit(area)
		else:
			SignalBus.OnPlayerReleaseCreature.emit()

func FindInput() -> Area2D: # Finds closes area 2D
	var ungroupedAreas : Array[Area2D] = %InteractionZone.get_overlapping_areas()
	var areas : Array[Area2D]
	
	for i in range(ungroupedAreas.size()):
		if ungroupedAreas[i].is_in_group("G_Interactable"):
			areas.insert(0, ungroupedAreas[i])
	
	if areas.size() == 1: return areas[0]
	if areas.size() > 1: return areas[randi_range(0, areas.size() - 1)]
	else: return null

func PlayFootstepSound() -> void:
	AudioManager.playSoundAtLocation(global_position, footstepSound)

func FreezePlayer(input : bool = false) -> void:
	canMove = input

func BindCreature(creature : Creature) -> void:
	boundCreature = creature

func ClearBoundCreature() -> void:
	boundCreature = null
