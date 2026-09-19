extends Node3D

const DEFAULT_HORSE = preload("uid://bxr034afn4d8e")
@export var tracks : Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for i in tracks.get_children():
		var horse_instance = DEFAULT_HORSE.instantiate()
		i.add_child(horse_instance)
		print (str(horse_instance.scale))
		# this may need to change, horses need to be child-ed under paths
		#horse_instance.global_position = global_position + Vector3(0, 0, i * -1);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
