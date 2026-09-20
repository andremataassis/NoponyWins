extends Node2D

@onready var neigh1 = $SFX_NEIGH_1

@onready var rng = RandomNumberGenerator.new()

func play():
	var randSound = rng.randi_range(1,1)
	match randSound:
		1:
			neigh1.volume_db = 2 + rng.randf_range(-1,1)
			neigh1.pitch_scale = 1 + rng.randf_range(0,0.3)
			neigh1.play(0.2)
