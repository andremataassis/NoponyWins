extends Node2D

@onready var jetpack1 = $SFX_JETPACK_1

@onready var rng = RandomNumberGenerator.new()

func play():
	var randSound = rng.randi_range(1,1)
	match randSound:
		1:
			jetpack1.volume_db = 4 + rng.randf_range(-1,1)
			jetpack1.pitch_scale = 1 + rng.randf_range(-0.1,0.1)
			jetpack1.play(0)
		
