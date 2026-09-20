extends Node
class_name Player

#Properties
var player_id = 0 #Ranges from 1 - 4
var device_id: int = -1
var color: Color = Color(0.956, 0.0, 0.04, 1.0)
var horse: Node = null
var charge_meter_ref: Node = null
var crosshair_ref: Node = null
var selected_power: Powers = Powers.NONE

var charge: float = 0
const MAX_CHARGE: float = 100

#Colors for each player, depending on player_id
const COLORS = [Color(1.0, 0.0, 0.0, 1.0), Color(0.0, 1.0, 0.0, 1.0), Color(0.0, 0.0, 1.0, 1.0), Color(0.967, 0.819, 0.0, 1.0)]
enum Powers {NONE, BOMB, JETPACK, PORTAL, AIRHORN}

func _init(pid: int, did: int, h: Node, char_meter: Node, crosshair: Node):
	player_id = pid
	device_id = did
	color = COLORS[pid - 1]
	horse = h
	charge_meter_ref = char_meter.get_child(0)
	crosshair_ref = crosshair

func set_horse(h: Horse):
	horse = h
	print("Player %d picked horse %s" % [player_id, h.horse_name])

func use_current_power():
	crosshair_ref.attack(selected_power)
	selected_power = Powers.NONE
	charge = 0.0

#call this in _process
func refill_meter(delta: float):
	charge += 20 * delta
	charge = min(charge, MAX_CHARGE)
	charge_meter_ref.value = charge

func handle_input(event: InputEvent):
	if event.is_action_pressed("bomb") && charge == 100.0:
		if selected_power == Powers.BOMB:
			print ("bombed! - Player %d" % [player_id])
			crosshair_ref.attack(Powers.BOMB)
			selected_power = Powers.NONE
			charge = 0.0
		else:
			print("Selected BOMB - Player %d" % [player_id])
			crosshair_ref.enable_crosshair()
			selected_power = Powers.BOMB
	
	if event.is_action_pressed("jetpack") && charge == 100.0:
		if selected_power == Powers.JETPACK:
			print("Nyoooooom- Player %d" % [player_id])
			crosshair_ref.attack(Powers.JETPACK)
			selected_power = Powers.NONE
			charge = 0.0
		else:
			print("Selected JETPACK - Player %d" % [player_id])
			crosshair_ref.enable_crosshair()
			selected_power = Powers.JETPACK
	
	if event.is_action_pressed("portal") && charge == 100.0:
		if selected_power == Powers.PORTAL:
			print("The cake is a lie- Player %d" % [player_id])
			crosshair_ref.attack(Powers.PORTAL)
			selected_power = Powers.NONE
			charge = 0.0
		else:
			print("Selected PORTAL - Player %d" % [player_id])
			crosshair_ref.enable_crosshair()
			selected_power = Powers.PORTAL
	
	if event.is_action_pressed("airhorn") && charge == 100.0:
		if selected_power == Powers.AIRHORN:
			print("FWOOOOOOOOO- Player %d" % [player_id])
			selected_power = Powers.NONE
			charge = 0.0
			crosshair_ref.attack(Powers.AIRHORN)
		else:
			print("Selected AIRHORN - Player %d" % [player_id])
			crosshair_ref.disable_crosshair()
			selected_power = Powers.AIRHORN

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
