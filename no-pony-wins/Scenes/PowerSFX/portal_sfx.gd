extends Node2D

@onready var portal1 = $SFX_PORTAL_1

@onready var rng = RandomNumberGenerator.new()

func play():
	var randSound = rng.randi_range(1,1)
	match randSound:
		1:
			portal1.volume_db = 2 + rng.randf_range(-1,1)
			portal1.pitch_scale = 1 + rng.randf_range(0,0.3)
			portal1.play(0.2)
