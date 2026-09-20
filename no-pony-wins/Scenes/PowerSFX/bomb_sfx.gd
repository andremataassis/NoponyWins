extends Node2D

@onready var bomb1 = $SFX_BOMB_1

@onready var rng = RandomNumberGenerator.new()

func play():
	var randSound = rng.randi_range(1,1)
	match randSound:
		1:
			bomb1.volume_db = 6 + rng.randf_range(-1,1)
			bomb1.pitch_scale = 1 + rng.randf_range(-0.1,0.1)
			bomb1.play(0.2)
		
