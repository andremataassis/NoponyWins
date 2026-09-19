extends Node3D

@onready var sfx_gallop = $GallopSFX

enum sfxType {
	GALLOP,
}

func play(soundEffect : String):
	var sfx = sfxType.get(soundEffect)
	get_child(sfx).play()
