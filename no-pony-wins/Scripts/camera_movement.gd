extends Node

@onready var camera: Camera3D = $"."
@onready var horse_tracks: Node3D = $"../HorseTracks"
var target: Node3D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# target just had to be something man idk
	# not even being used tbh
	target = horse_tracks

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# change to target.global_position once lead horse input is figured out
	# currently fixated on horse 4
	camera.look_at(horse_tracks.get_child(4).get_child(0).global_position)

# called from other script with $Camera3D.switch_target(new_node)
# or $camera_movement.switch_target(new_node), idrk
# meant to track lead horse, idk if that's happening
func switch_target(new_target: Node3D) -> void:
	target = new_target
