extends Node3D

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
	# look towards the winner
	var winner_location = global_transform.looking_at(_find_winning_horse_position())
	global_transform = global_transform.interpolate_with(winner_location, 10 * _delta)

# finds the furthest ahead horse and returns its position
func _find_winning_horse_position() -> Vector3:
	var farthest_percent : float = -1
	var farthest_lap : int = -1
	
	var target_location : Vector3
	for track : Node3D in horse_tracks.get_children():
		var horse : Horse = track.get_child(0)
		# check if this horse is ahead
		if ((horse.progress_ratio > farthest_percent
			and horse.lap >= farthest_lap)
			or horse.lap > farthest_lap):
			farthest_percent = horse.progress_ratio
			farthest_lap = horse.lap
			target_location = horse.global_position
	# return findings
	return target_location

# called from other script with $Camera3D.switch_target(new_node)
# or $camera_movement.switch_target(new_node), idrk
# meant to track lead horse, idk if that's happening
func switch_target(new_target: Node3D) -> void:
	target = new_target
