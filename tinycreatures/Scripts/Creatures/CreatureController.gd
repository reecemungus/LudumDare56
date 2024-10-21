extends CharacterBody2D
class_name CreatureController

### INFO 
## Class to control a creature scene in game, owns a creature as a child

var creatureRes : Creature = Creature.new()
var CREATUREVIEWUI 

@onready var player : PlayerController = get_tree().get_first_node_in_group("G_PlayerController")
var isBoundToPlayer : bool = false

var targetLocation : Vector2

var speakSounds : Array[AudioStream] = [
	preload("res://Assets/Audio/Peep.wav"), 
	preload("res://Assets/Audio/Bleat.wav"), 
	preload("res://Assets/Audio/Burp.wav"), 
	preload("res://Assets/Audio/Call.wav"), 
	preload("res://Assets/Audio/Meow.wav"), 
	preload("res://Assets/Audio/Squeak.wav"), 
	preload("res://Assets/Audio/Whistle.wav")]

var pickupSound : AudioStream = preload("res://Assets/Audio/Pickup.wav")
var dropSound : AudioStream = preload("res://Assets/Audio/Drop.wav")

var deathParticleScene : PackedScene = preload("res://Scenes/Particles/CreatureDeathParticles.tscn")

func _ready() -> void:	
	SignalBus.CreatureUpdateSprite.connect(UpdateSprite)
	SignalBus.OnPlayerReleaseCreature.connect(OnDragEnd)
	SignalBus.KillBoundCreature.connect(KillBoundCreature)
	
	%SpeakTimer.wait_time = 7.0 + randf_range(-2, 6)

func _physics_process(delta: float) -> void:
	var distanceToPlayer : Vector2 = player.global_position - global_position
	
	if isBoundToPlayer && distanceToPlayer.length() > 2.0:
		targetLocation = ConstrainDistance(global_position, player.global_position, 5.0)
		velocity = distanceToPlayer.normalized() * 4000 * delta
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

func UpdateSprite() -> void:
	match creatureRes.GrowthStage:
		Game.GrowthStage.SEED:
			%CreatureSprite.texture = creatureRes.SeedSprite
		Game.GrowthStage.SPROUT:
			%CreatureSprite.texture = creatureRes.SproutSrite
		Game.GrowthStage.GROWN:
			%CreatureSprite.texture = creatureRes.GrownSprite

func OnInteract() -> void:
	if !CREATUREVIEWUI:
		CREATUREVIEWUI = preload("res://Scenes/UI/CreatureViewUI.tscn").instantiate()
		var PlayerHud : CanvasLayer = get_tree().get_first_node_in_group("G_PlayerHUD")
		
		CREATUREVIEWUI.creature = creatureRes
		PlayerHud.add_child(CREATUREVIEWUI)

func OnDrag() -> void:
	AudioManager.playSoundAtLocation(global_position, pickupSound)
	
	isBoundToPlayer = true
	SignalBus.BindCreatureToPlayer.emit(creatureRes)
	
	%InteractArea.set_collision_layer_value(1, false)
	%InteractArea.set_collision_mask_value(1, false)

func OnDragEnd() -> void:
	AudioManager.playSoundAtLocation(global_position, dropSound)
	
	isBoundToPlayer = false
	
	%InteractArea.set_collision_layer_value(1, true)
	%InteractArea.set_collision_mask_value(1, true)

func KillBoundCreature() -> void:
	if isBoundToPlayer:
		var deathPart = deathParticleScene.instantiate()
		player.add_child(deathPart)
		deathPart.global_position = global_position
		
		queue_free()

func ConstrainDistance(point : Vector2, anchor : Vector2, distance : float) -> Vector2:
	return ((point - anchor).normalized() * distance) + anchor

func _on_speak_timer_timeout() -> void:
	if creatureRes.GrowthStage == Game.GrowthStage.SPROUT or creatureRes.GrowthStage == Game.GrowthStage.GROWN:
		AudioManager.playSoundAtLocation(global_position, speakSounds[randi_range(0,speakSounds.size() - 1)])
