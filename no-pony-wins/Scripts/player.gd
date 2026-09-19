extends Node
class_name Player

#Properties
var player_id = 0 #Ranges from 1 - 4
var device_id: int = -1
var color: Color = Color(0.956, 0.0, 0.04, 1.0)
var horse: Node = null
var charge_meter_ref: Node = null
var crosshair_ref: Node = null

var charge: float = 0
const MAX_CHARGE: float = 100

#Colors for each player, depending on player_id
const COLORS = [Color(1.0, 0.0, 0.0, 1.0), Color(0.0, 1.0, 0.0, 1.0), Color(0.0, 0.0, 1.0, 1.0), Color(0.967, 0.819, 0.0, 1.0)]

func _init(pid: int, did: int, h: Node, char_meter: Node, crosshair: Node):
	player_id = pid
	device_id = did
	color = COLORS[pid - 1]
	horse = h
	charge_meter_ref = char_meter
	crosshair_ref = crosshair

func _pick_horse(h: Node):
	horse = h

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _refill_meter(delta: float) -> float:
	charge += 20 * delta
	charge = min(charge, MAX_CHARGE)
	charge_meter_ref.value = charge
	return charge

func _use_power(delta: float, event: InputEvent):
	var meter = _refill_meter(delta)
		
	if event.is_action_just_pressed("bomb") && meter == 100.0:
		print ("bombed! - Player %d" % [player_id])
		crosshair_ref.crosshair_enable("bomb") # FIX get_child(0) param to playerNum
		charge = 0.0
	
	if event.is_action_just_pressed("jetpack") && meter == 100.0:
		print("Nyoooooom- Player %d" % [player_id])
		crosshair_ref.crosshair_enable("jetpack")
		charge = 0.0
	
	if event.is_action_just_pressed("portal") && meter == 100.0:
		print("The cake is a lie- Player %d" % [player_id])
		crosshair_ref.crosshair_enable("portal")
		charge = 0.0
	
	if event.is_action_just_pressed("airhorn") && meter == 1.0:
		print("FWOOOOOOOOO- Player %d" % [player_id])
		meter = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
