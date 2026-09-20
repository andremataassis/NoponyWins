extends Node3D
class_name RaceHandler

enum RaceState {ADDING_PLAYERS, PICKING_HORSES, RACING, GAME_OVER}
@export var ui_spawner: UISpawner
@export var horse_manager: HorseManager

var player_array: Array[Player] = []
const MAX_PLAYERS = 4
var race_state = RaceState.ADDING_PLAYERS
var player_picking = -1

var horse_button_vals: Dictionary = {
	JOY_BUTTON_A: 7,
	JOY_BUTTON_B: 6,
	JOY_BUTTON_X: 5,
	JOY_BUTTON_Y: 4,
	JOY_BUTTON_DPAD_UP: 3,
	JOY_BUTTON_DPAD_RIGHT: 2,
	JOY_BUTTON_DPAD_DOWN: 1,
	JOY_BUTTON_DPAD_LEFT: 0,
	KEY_Z: 7,
	KEY_X: 6,
	KEY_C: 5,
	KEY_V: 4,
	KEY_UP: 3,
	KEY_RIGHT: 2,
	KEY_DOWN: 1,
	KEY_LEFT: 0
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	#Ignore mouse and joypad events
	if event is InputEventMouse: return
	if event is InputEventJoypadMotion: return
	
	#handle input based on race state
	if race_state == RaceState.ADDING_PLAYERS:
		#add the player to the game if it is new input
		if _check_if_player_added(event.device) == false and player_array.size() < MAX_PLAYERS:
			_add_player(event)
		#proceed to pick horses when confirmed
		if event.is_action_pressed("confirm"): 
			race_state = RaceState.PICKING_HORSES
			ui_spawner.init_horse_selection_screen(horse_manager.active_horses)
			player_picking = 1
	if race_state == RaceState.PICKING_HORSES:
		_pick_horse(event)
	if race_state == RaceState.RACING:
		_handle_player_input(event)

func _pick_horse(event: InputEvent):
	if not event.is_pressed() or event.is_echo(): return
	var player: Player = _get_player_from_device(event.device)
	if player == null or player.player_id != player_picking: 
		if player != null: print("Not player %d turn to pick!" % [player.player_id])
		return
	print("Correct player")
	var button = null
	if event is InputEventJoypadButton: button = event.button_index
	elif event is InputEventKey: button = event.keycode
	
	if horse_button_vals.has(button):
		var assigned_number: int = horse_button_vals[button]
		var horse_ref = horse_manager.active_horses[assigned_number]
		player.set_horse(horse_ref)
		player_picking += 1
		ui_spawner.update_horse_selection_ui(player_picking)
		if player_picking > player_array.size(): _start_race()
	pass

func _start_race():
	ui_spawner.delete_horse_selection_ui()
	horse_manager.unpause_horses()
	race_state = RaceState.RACING
	print("Started Race!")

func win_race(horse: Horse):
	var win_player: Array[String] = []
	for player in player_array:
		if player.horse == horse:
			win_player.append("Player %d" % [player.player_id])
	ui_spawner.spawn_win_screen(win_player, horse)

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
func _check_if_player_added(device_id: int) -> bool:
	for player in player_array:
		if player.device_id == device_id: return true
	return false

func _get_player_from_device(device_id: int) -> Player:
	for player in player_array:
		if player.device_id == device_id: return player
	return null

func _add_player(event: InputEvent):
	var device_id = event.device
	var player_id = player_array.size() + 1
	var crosshair = ui_spawner.make_crosshair(Player.COLORS[player_id - 1])
	var charge_meter = ui_spawner.place_charge_meter(player_id, Player.COLORS[player_id - 1]) 
	var player = Player.new(player_id, device_id, null, charge_meter, crosshair)
	player_array.append(player)
	print("Player %d added with device %d and crosshair %d" % [player.player_id, player.device_id, crosshair.get_instance_id()])

func neigh_used():
	for player in player_array:
		player.use_current_power()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if race_state == RaceState.RACING:
		for player in player_array:
			player.refill_meter(delta)
