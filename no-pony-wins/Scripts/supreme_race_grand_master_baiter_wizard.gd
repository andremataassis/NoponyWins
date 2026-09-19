extends Node3D

enum RaceState {PICKING_HORSES, RACING, GAME_OVER}
@export var ui_spawner: UI_SPAWNER

var player_array: Array[Player] = []
var race_state = RaceState.PICKING_HORSES

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if race_state == RaceState.PICKING_HORSES:
		#add the player to the game if it is new input
		if _check_if_player_added(event.device) == false:
			_add_player(event)
		#pick horse if they have already been added
		else:
			_pick_horse(event)

func _pick_horse(event: InputEvent):
	print("Player already added!")
	pass

#returns true if the player with device_id has already been added to the game
func _check_if_player_added(device_id: int):
	for player in player_array:
		if player.device_id == device_id: return true
	return false

func _add_player(event: InputEvent):
	var device_id = event.device
	var player_id = player_array.size() + 1
	var crosshair = ui_spawner.make_crosshair()
	var charge_meter = ui_spawner.place_charge_meter() 
	var player = Player.new(player_id, device_id, null, charge_meter, crosshair)
	player_array.append(player)
	print("Player %d added!" % [player.player_id])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
