class_name SM extends Node

# Static reference
# singleton design pattern
static var inst : SM

enum Scene {
	Start,
	Game,
}

const START_MENU = preload("uid://bh25gyoc63jxe")
const MAIN_SCENE = preload("uid://p6y218jucqe3")

var _current_scene : Node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inst = self
	
	load_scene(Scene.Start)

func load_scene(destination : Scene):
	# delete existing if exists
	if _current_scene != null:
		_current_scene.queue_free()
	
	# instantiate the current scene
	var next_scene : Node
	match(destination):
		Scene.Start:
			next_scene = START_MENU.instantiate()
		Scene.Game:
			next_scene = MAIN_SCENE.instantiate()
	add_child(next_scene)
	_current_scene = next_scene
	
	
