extends Node3D

const DEFAULT_HORSE = preload("uid://bxr034afn4d8e")
@export var tracks : Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#instantiate horses
	for i in tracks.get_children():
		var horse_instance = DEFAULT_HORSE.instantiate()
		i.add_child(horse_instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
