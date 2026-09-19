extends Node

@onready var camera: Camera3D = $Camera3D
@onready var horse_tracks: Node3D = $HorseTracks
@onready var ui: Node2D = $CanvasLayer/Ui

var health: float
var max_health: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# fix camera on horse 4, may or may not be implemented
	#camera.switch_target(horse_tracks.get_child(4).get_child(0))
	health = ui.get_child(1).get_child(0).value
	max_health = ui.get_child(1).get_child(0).max_value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var meter = _refill_meter(delta)
		
	if Input.is_action_just_pressed("bomb") && meter == 100.0:
		print ("bombed!")
		ui.get_child(0).crosshair_enable("bomb") # FIX get_child(0) param to playerNum
		health = 0.0
	
	if Input.is_action_just_pressed("jetpack") && meter == 100.0:
		print("Nyoooooom")
		ui.get_child(0).crosshair_enable("jetpack")
		health = 0.0
	
	if Input.is_action_just_pressed("portal") && meter == 100.0:
		print("The cake is a lie")
		ui.get_child(0).crosshair_enable("portal")
		health = 0.0
	
	if Input.is_action_just_pressed("airhorn") && meter == 1.0:
		print("FWOOOOOOOOO")
		meter = 0.0

func _refill_meter(delta: float) -> float:
	health += 20 * delta
	health = min(health, max_health)
	ui.get_child(1).get_child(0).value = health
	return health
