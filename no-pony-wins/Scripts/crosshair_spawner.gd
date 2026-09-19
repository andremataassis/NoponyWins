extends Node2D

const CROSSHAIR = preload("uid://ctxwinfr06la4")
const POWER_METER = preload("uid://efwrq0olilm1")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var crosshair_instance = CROSSHAIR.instantiate()
	add_child(crosshair_instance)
	var progress_instance = POWER_METER.instantiate()
	add_child(progress_instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
