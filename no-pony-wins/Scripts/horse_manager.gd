extends Node3D
class_name HorseManager

const DEFAULT_HORSE = preload("uid://bxr034afn4d8e")
const JAMES_BIRD = preload("uid://bhk88s3aucapw")
const DRAGON_HORSE = preload("uid://kyp588xilrbt")
const UNICORN = preload("uid://pjbv0asbot3v")
const TIMM_HORSE = preload("uid://dys2vux5kc3b3")
const TROPHY_HORSE = preload("uid://dm5mcf7w6myrw")
const DEVEN_HORSE = preload("uid://dv4kb1nbw3d3a")
const __HORSE = preload("uid://bob0lrymw50b3")

@export var tracks : Node3D
var active_horses: Array[Horse] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var horses = [DEFAULT_HORSE, JAMES_BIRD, DRAGON_HORSE, UNICORN, TIMM_HORSE, TROPHY_HORSE, DEVEN_HORSE, __HORSE]
	#instantiate horses
	for i in tracks.get_children():
		var h = randi_range(0, horses.size() - 1)
		var horse_instance = horses[h].instantiate()
		horses.remove_at(h)
		i.add_child(horse_instance)
		active_horses.append(horse_instance)

func pause_horses():
	for horse in active_horses:
		horse.toggle_racing(false)

func unpause_horses():
	for horse in active_horses:
		horse.toggle_racing(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
