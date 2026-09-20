extends Control
class_name UISpawner

const CROSSHAIR = preload("uid://ctxwinfr06la4")
const CHARGE_METER = preload("res://Scenes/UI/charge_meter.tscn")
const HORSE_SELECTION = preload("uid://bni63ghyc7tpx")
const TIMM_HORSE_SS = preload("uid://7p0c6axvawmg")
var horse_sel_instance = null
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

func init_horse_selection_screen(horses: Array[Horse]):
	get_child(0).queue_free()
	horse_sel_instance = HORSE_SELECTION.instantiate()
	add_child(horse_sel_instance)
	var horse_names = horse_sel_instance.get_child(0).get_child(0).get_child(0)
	var horse_images = horse_sel_instance.get_child(0).get_child(0).get_child(1)
	var player_text = horse_sel_instance.get_child(0).get_child(0).get_child(3)
	player_text.text = "Player 1, select yer horsey!!"
	for i in 8:
		var horse = horses[i]
		horse_names.get_child(7 - i).text = horse.horse_name
		if horse.get_child(0).get_child(2) is Sprite3D:
			horse_images.get_child(7 - i).texture = horse.get_child(0).get_child(2).texture
		else:
			horse_images.get_child(7 - i).texture = TIMM_HORSE_SS

func update_horse_selection_ui(pid: int):
	var player_text = horse_sel_instance.get_child(0).get_child(0).get_child(3)
	player_text.text = "Player %d, select yer horsey!!" % [pid]

func delete_horse_selection_ui():
	if horse_sel_instance != null:
		horse_sel_instance.queue_free()

func place_charge_meter(player_id : int, color: Color):
	var charge_instance = CHARGE_METER.instantiate()
	add_child(charge_instance)
	var stylebox = StyleBoxFlat.new()
	charge_instance.get_child(0).add_theme_stylebox_override("fill", stylebox)
	stylebox.bg_color = color
	charge_instance.get_child(0).position = Vector2(((canvas_size.x - canvas_size.x / 15) / 4) * (player_id - 1) + canvas_size.x / 15, canvas_size.y - canvas_size.y / 15)
	return charge_instance

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
