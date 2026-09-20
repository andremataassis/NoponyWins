extends Node3D

@export var corner: Node3D
@export var dudes_count: int = 50
const DUDE = preload("uid://ivpbt6103a21")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in dudes_count:
		var dude_instance = DUDE.instantiate()
		add_child(dude_instance)
		dude_instance.global_position = Vector3(randf_range(global_position.x, corner.global_position.x),global_position.y, randf_range(global_position.z, corner.global_position.z))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
