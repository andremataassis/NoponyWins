extends Node
const DUDE_1 = preload("uid://cmlccalu8u4vy")
const DUDE_2 = preload("uid://cf6vg0ktqs620")
const DUDE_3 = preload("uid://buqsqg42uhuwk")
const DUDE_4 = preload("uid://dedvctfkripw6")
const DUDE_5 = preload("uid://c7a028vu4o8b6")
const DUDE_6 = preload("uid://diixsuptpw5gt")
var dude_list: Array[Texture2D] = [DUDE_1, DUDE_2, DUDE_3, DUDE_4, DUDE_5, DUDE_6]
var start_y: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_child(0).texture = dude_list[randi_range(0, dude_list.size())]
	start_y = get_child(0).offset.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var time = Time.get_ticks_msec() / 100.0
	get_child(0).offset.y = start_y + sin(time) * 100 + 20
	pass
