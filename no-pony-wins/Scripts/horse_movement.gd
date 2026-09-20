extends Node3D
class_name Horse

var lap : int = 0
@onready var horseSFX = $Horse/HorseSFX
@onready var rng = RandomNumberGenerator.new()

@export var move_speed = 0.1
@export var horseGallopCooldown : float = 0.4
@export var horse_name = "default"
var horseGallopTimer : float = 0
var racing = false

var _time_alive := 0.0
const NUM_RACER_VARIANCE_TERMS = 8
var _racer_variance_parameters : Array[float] = []
var _advantage : float = 1.0


# Called when the node enters the scene tree for the first time.
# idk maybe make them wait for the start of the race here???
func _ready() -> void:
	horseGallopTimer = horseGallopCooldown + rng.randf_range(-0.1,0.1)
	
	# Decide racer trajectory
	for pi in NUM_RACER_VARIANCE_TERMS:
		_racer_variance_parameters.append(1) # timescale
		_racer_variance_parameters.append(randf() * 2 * PI) # offset
	
	# the one that matters
	_advantage = randf() * .04
	#print(str(get_parent().name) + " has " + str(_advantage))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not racing: return

	_time_alive += delta
	
	var old_progress = progress_ratio
	progress_ratio += move_speed * _get_move_step() * delta
	
	# check if we progressed a lap
	if old_progress > progress_ratio:
		lap += 1 # happens when resets to 0
		#print("lapped! " + str(lap))
	
	if horseGallopTimer > 0:
		horseGallopTimer -= delta
	else:
		horseGallopTimer = horseGallopCooldown
		horseSFX.play("GALLOP")

func toggle_racing(r: bool):
	racing = r
 
# evalutes the sin function 
func _get_move_step():
	var accumalted := 0.0
	for pi : int in NUM_RACER_VARIANCE_TERMS:
		if pi % 2 == 0:
			accumalted += sin(_time_alive * _racer_variance_parameters[pi * 2]
				+ _racer_variance_parameters[pi * 2 + 1])
		else:
			accumalted += cos(_time_alive * _racer_variance_parameters[pi * 2]
				+ _racer_variance_parameters[pi * 2 + 1])
	# regulate the value for use
	accumalted = 1 + accumalted / NUM_RACER_VARIANCE_TERMS / 2 + _advantage
	return accumalted

# these guys are called from the crosshair script (to be added)
func bomb() -> void:
	move_speed = 0.01

func jetpack() -> void:
	move_speed = 1.0

func reset_speed() -> void:
	move_speed = 0.1
