extends Node2D
class_name Crosshair

@onready var crosshair: Node2D = $"."
@onready var horse_tracks: Node3D = $"../../../HorseTracks"
@onready var powerSFX = $PowerSFX
@onready var race_handler : RaceHandler = get_tree().current_scene
var start_y: float
var enabled_time: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	crosshair.hide()
	start_y = position.y
	enabled_time = Time.get_ticks_msec()

func enable_crosshair() -> void:
	position.y = start_y
	crosshair.show()
	enabled_time = Time.get_ticks_msec()
	
func disable_crosshair() -> void:
	crosshair.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# crosshair movement
	var time = (enabled_time - Time.get_ticks_msec()) / 100.0
	position.y = start_y + sin(time) * 150 + 50

func attack(power : Player.Powers) -> void:
	if power == Player.Powers.NONE: return
	# map position.y to horse number
	var horse = round(8 - ((position.y - 150) * 7 / 300))
	print(horse)
	
	disable_crosshair()

	match (power):
		Player.Powers.BOMB:
			# play bomb sound
			powerSFX.play("BOMB")
			# get horses in blast
			var targets = [-1, horse, -1]
			if horse - 1 >= 0:
				targets[0] = horse - 1
			if horse + 1 <= 7:
				targets[2] = horse + 1
			
			# bomb them
			for target in targets:
				# horse DNE
				if (target == -1):
					continue
				horse_tracks.get_child(target).get_child(0).bomb()
			
			# wait
			await get_tree().create_timer(1.0).timeout
			
			# reset speed
			for target in targets:
				if (target == -1):
					continue
				horse_tracks.get_child(target).get_child(0).reset_speed()
		Player.Powers.JETPACK:
			horse_tracks.get_child(horse).get_child(0).jetpack()
			await get_tree().create_timer(1.0).timeout
			horse_tracks.get_child(horse).get_child(0).reset_speed()
		Player.Powers.PORTAL:
			var rng = RandomNumberGenerator.new()
			var target2 = rng.randi_range(0, 7)
			horse_tracks.get_child(target2).get_child(0).reparent(horse_tracks.get_child(horse), false)
			horse_tracks.get_child(horse).get_child(0).reparent(horse_tracks.get_child(target2), false)
		Player.Powers.AIRHORN:
			print("broadcasted")
			race_handler.airhorn_used()
			pass
