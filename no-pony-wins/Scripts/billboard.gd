extends Node3D

#==============================
#  Makes the given Node3D rotate towards the camera
#==============================

@export var apply_to_children = false

# Reference to camera
var _camera : Camera3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_camera = get_viewport().get_camera_3d()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if apply_to_children:
		for child : Node3D in get_children():
			child.look_at(_camera.position)
	else:
		look_at(_camera.position)
