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
	charge_meter_ref = char_meter.get_child(0)
	crosshair_ref = crosshair

func _set_horse(h: Node):
	horse = h

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#call this in _process
func refill_meter(delta: float):
	charge += 20 * delta
	charge = min(charge, MAX_CHARGE)
	charge_meter_ref.value = charge

func handle_input(event: InputEvent):
	select_power(event)

func select_power(event: InputEvent):
	if event.is_action_pressed("bomb") && charge == 100.0:
		print ("bombed! - Player %d" % [player_id])
		crosshair_ref.crosshair_enable("bomb") # FIX get_child(0) param to playerNum
		charge = 0.0
	
	if event.is_action_pressed("jetpack") && charge == 100.0:
		print("Nyoooooom- Player %d" % [player_id])
		crosshair_ref.crosshair_enable("jetpack")
		charge = 0.0
	
	if event.is_action_pressed("portal") && charge == 100.0:
		print("The cake is a lie- Player %d" % [player_id])
		crosshair_ref.crosshair_enable("portal")
		charge = 0.0
	
	if event.is_action_pressed("airhorn") && charge == 1.0:
		print("FWOOOOOOOOO- Player %d" % [player_id])
		charge = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
