extends Node

@onready var camera: Camera3D = $Camera3D
@onready var horse_tracks: Node3D = $HorseTracks
@onready var ui: Node2D = $CanvasLayer/Ui

# handle all race stuff here
# specifically, i'm thinking:
# - lead horse tracking / win
# - input handling
# - perhaps item meter


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# fix camera on horse 4, may or may not be implemented
	#camera.switch_target(horse_tracks.get_child(4).get_child(0))
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var meter = 1.0
	if meter < 1.0:
		meter += 0.1
		
	if Input.is_action_just_pressed("bomb") && meter == 1.0:
		print ("bombed!")
		ui.get_child(0).crosshair_enable("bomb") # FIX get_child(0) param to playerNum
		meter = 0.0
	
	if Input.is_action_just_pressed("jetpack") && meter == 1.0:
		print("Nyoooooom")
		ui.get_child(0).crosshair_enable("jetpack")
		meter = 0.0
	
	if Input.is_action_just_pressed("portal") && meter == 1.0:
		print("The cake is a lie")
		meter = 0.0
	
	if Input.is_action_just_pressed("airhorn") && meter == 1.0:
		print("FWOOOOOOOOO")
		meter = 0.0
