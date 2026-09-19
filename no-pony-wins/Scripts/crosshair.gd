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
	var time = Time.get_ticks_msec() / 10
	position.y = start_y + sin(time) * 150 + 50
	
	# map position.y to horse number
	var target = (position.y - 150) * 7 / 300 - 1
	
	# attack!!
	if power != "":
		if Input.is_action_just_pressed("confirm") && crosshair.visible:
			print (round(target))
			_attack(round(target))

func _attack(horse: int) -> void:
	# get all horses affected
	var targets = [-1, horse, -1]
	if horse - 1 >= 0:
		targets[0] = horse - 1
	if horse + 1 <= 7:
		targets[2] = horse + 1
	
	for target in targets:
		# horse DNE
		if (target == -1):
			continue
		
		match (power):
			"bomb": 
				horse_tracks.get_child(target).get_child(0).bomb()
			"jetpack":
				horse_tracks.get_child(target).get_child(0).jetpack()
			"portal":
				pass
			"airhorn":
				pass
	
	await get_tree().create_timer(1.0).timeout
	
	for target in targets:
		horse_tracks.get_child(target).get_child(0).reset_speed()
	
	crosshair.hide()
