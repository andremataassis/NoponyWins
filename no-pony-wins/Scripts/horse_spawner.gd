extends Node3D

const DEFAULT_HORSE = preload("uid://bxr034afn4d8e")
const JAMES_BIRD = preload("uid://bhk88s3aucapw")
const DRAGON_HORSE = preload("uid://kyp588xilrbt")
const UNICORN = preload("uid://pjbv0asbot3v")

@export var tracks : Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var horses = [DEFAULT_HORSE, JAMES_BIRD, DRAGON_HORSE, UNICORN]
	#instantiate horses
	for i in tracks.get_children():
		var horse_instance = horses.pick_random().instantiate()
		i.add_child(horse_instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
