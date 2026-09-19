extends Node2D

const CROSSHAIR = preload("uid://ctxwinfr06la4")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var crosshair_instance = CROSSHAIR.instantiate()
	add_child(crosshair_instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
