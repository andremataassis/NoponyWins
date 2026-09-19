extends Node3D

@onready var gallop1 = $SFX_Gallop_1
@onready var gallop2 = $SFX_Gallop_2
@onready var gallop3 = $SFX_Gallop_3
@onready var rng = RandomNumberGenerator.new()

func play():
	var randSound = rng.randi_range(2,4)
	match randSound:
		1:
			gallop1.volume_db = -6 + rng.randf_range(-1,1)
			gallop1.pitch_scale = 1 + rng.randf_range(-0.9,0.1)
			gallop1.play()
		2:
			gallop1.volume_db = -6 + rng.randf_range(-1,1)
			gallop1.pitch_scale = 1 + rng.randf_range(-0.9,0.1)
			gallop1.play()
		3:
			gallop2.volume_db = -6 + rng.randf_range(-1,1)
			gallop2.pitch_scale = 1 + rng.randf_range(-0.9,0.1)
			gallop2.play()
		4:
			gallop3.volume_db = -6 + rng.randf_range(-1,1)
			gallop3.pitch_scale = 1 + rng.randf_range(-0.9,0.1)
			gallop3.play()
	
