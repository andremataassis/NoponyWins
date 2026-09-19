extends Node

@onready var camera: Camera3D = $Camera3D
@onready var horse_tracks: Node3D = $HorseTracks

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
func _process(delta: float) -> void:
	pass
