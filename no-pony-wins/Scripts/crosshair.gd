extends Node2D

@onready var crosshair: Node2D = $"."
@onready var horse_tracks: Node3D = $"../../../HorseTracks"
var power: String
var start_y: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	crosshair.hide()
	start_y = position.y
	power = "bomb"

func crosshair_enable(input: String) -> void:
	crosshair.show()
	power = input

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# crosshair movement
	var time = Time.get_ticks_msec() / 10.0
	position.y = start_y + sin(time) * 150 + 50
	
	# map position.y to horse number
	var target = (position.y - 150) * 7 / 300 - 1
	
	# attack!!
	if power != "":
		if Input.is_action_just_pressed("confirm") && crosshair.visible:
			print (round(target))
			_attack(round(target))

func _attack(horse: int) -> void:
	crosshair.hide()

	match (power):
		"bomb":
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
		"jetpack":
			horse_tracks.get_child(horse).get_child(0).jetpack()
			await get_tree().create_timer(1.0).timeout
			horse_tracks.get_child(horse).get_child(0).reset_speed()
		"portal":
			var rng = RandomNumberGenerator.new()
			var target2 = rng.randi_range(0, 7)
			horse_tracks.get_child(target2).get_child(0).reparent(horse_tracks.get_child(horse), false)
			horse_tracks.get_child(horse).get_child(0).reparent(horse_tracks.get_child(target2), false)
		"airhorn":
			pass
