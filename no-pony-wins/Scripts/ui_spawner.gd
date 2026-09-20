extends Node2D
class_name UI_SPAWNER

const CROSSHAIR = preload("uid://ctxwinfr06la4")
const CHARGE_METER = preload("res://Scenes/charge_meter.tscn")
var canvas_size: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	canvas_size = get_viewport().get_visible_rect().size
	
func make_crosshair(c : Color):
	var crosshair_instance = CROSSHAIR.instantiate()
	add_child(crosshair_instance)
	crosshair_instance.get_child(0).modulate = c
	return crosshair_instance

func place_charge_meter(player_id : int):
	var charge_instance = CHARGE_METER.instantiate()
	add_child(charge_instance)
	charge_instance.get_child(0).position = Vector2(((canvas_size.x - canvas_size.x / 15) / 4) * (player_id - 1) + canvas_size.x / 15, canvas_size.y - canvas_size.y / 15)
	return charge_instance

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
