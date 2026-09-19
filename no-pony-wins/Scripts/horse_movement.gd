extends Node3D

@onready var path_follow_3d: PathFollow3D = $"."
var move_speed = 0.1

# Called when the node enters the scene tree for the first time.
# idk maybe make them wait for the start of the race here???
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	path_follow_3d.progress_ratio += move_speed * delta

# these guys are called from the crosshair script (to be added)
func bomb() -> void:
	move_speed = 0.01

func jetpack() -> void:
	move_speed = 1.0

func reset_speed() -> void:
	move_speed = 0.1
