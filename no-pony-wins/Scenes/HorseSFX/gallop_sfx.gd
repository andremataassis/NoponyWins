extends Node3D

@onready var gallop1 = $SFX_Gallop_1
@onready var rng = RandomNumberGenerator.new()

func play():
	gallop1.volume_db = -6 + rng.randf_range(-1,1)
	gallop1.pitch_scale = 1 + rng.randf_range(-0.1,0.1)
	gallop1.play()
	
