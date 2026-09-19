extends Node3D

enum RaceState {PICKING_HORSES, RACING, GAME_OVER}
@export var ui_spawner: UI_SPAWNER

var player_array: Array[Player] = []
var race_state = RaceState.PICKING_HORSES

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	#Ignore mouse events
	if event is InputEventMouse: return
	
	#handle input based on race state
	if race_state == RaceState.PICKING_HORSES:
		#add the player to the game if it is new input
		if _check_if_player_added(event.device) == false:
			_add_player(event)
			race_state = RaceState.RACING
		#pick horse if they have already been added
		else:
			_pick_horse(event)
	if race_state == RaceState.RACING:
		_handle_player_input(event)

func _pick_horse(event: InputEvent):
	print("Player already added!")
	pass

func _handle_player_input(event: InputEvent):
	#get player
	var player: Player = null
	for p in player_array:
		if p.device_id == event.device: 
			player = p
			break
			
	#if the player isn't registered, something is royally fucked up
	if player == null:
		push_error("UNREGISTERED DEVICE INPUT device_id:%d - _handle_player_input", [event.device])
		pass
	
	player.handle_input(event)

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
	print("Player %d added with device %d" % [player.player_id, player.device_id])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if race_state == RaceState.RACING:
		for player in player_array:
			player.refill_meter(delta)
