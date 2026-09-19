extends Node2D
class_name UI_SPAWNER

const CROSSHAIR = preload("uid://ctxwinfr06la4")
const CHARGE_METER = preload("uid://efwrq0olilm1")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func make_crosshair() :
	var crosshair_instance = CROSSHAIR.instantiate()
	add_child(crosshair_instance)
	return crosshair_instance

func place_charge_meter():
	var charge_instance = CHARGE_METER.instantiate()
	add_child(charge_instance)
	return charge_instance

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
