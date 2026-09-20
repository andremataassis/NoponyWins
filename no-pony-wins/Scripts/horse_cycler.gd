extends Node3D

const HASHTAG_HORSE = preload("uid://bob0lrymw50b3")
const DEFAULT_HORSE = preload("uid://bxr034afn4d8e")
const DEVEN_HORSE = preload("uid://dv4kb1nbw3d3a")
const DRAGON_HORSE = preload("uid://kyp588xilrbt")
const TIMM_HORSE = preload("uid://dys2vux5kc3b3")
const TOTALLY_A_HORSE = preload("uid://cpeylqdshx21h")
const TROPHY_HORSE = preload("uid://dm5mcf7w6myrw")
const JAMES_BIRD = preload("uid://bhk88s3aucapw")
const UNICORN = preload("uid://pjbv0asbot3v")
const GOBBY_HORSE = preload("uid://uxlf0phdy78l")

var _horses_references := [HASHTAG_HORSE, DEFAULT_HORSE, DEVEN_HORSE, UNICORN,
	DRAGON_HORSE, TIMM_HORSE, TOTALLY_A_HORSE, TROPHY_HORSE, JAMES_BIRD, GOBBY_HORSE]

# used for spawning time
@onready var timer: Timer = $Timer
@export var interval : float
@export var direction : Vector3

var _spawned_horses : Array[Node3D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_horse_cycle()

# spawns horses and calls itself after a pause
func spawn_horse_cycle():
	var h : Node3D = _horses_references.pick_random().instantiate()
	add_child(h)
	h.position = Vector3.ZERO
	_spawned_horses.append(h)
	h.set_physics_process(false)
	h.set_process(false)
	h.set_process_input(false)
	
	# Spawn the next horse in a bit
	timer.start(interval)
	await timer.timeout
	spawn_horse_cycle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for h : Node3D in _spawned_horses:
		if h.is_queued_for_deletion(): continue
		
		h.position += direction * delta
		h.rotate(Vector3.UP, 1.2 * delta)
		if h.position.length() > 20:
			h.queue_free()
			_spawned_horses.erase(h)
