extends Node2D

@onready var sfx_bomb = $BombSFX

enum sfxType {
	BOMB,
	JETPACK
}

func play(soundEffect : String):
	var sfx = sfxType.get(soundEffect)
	get_child(sfx).play()
