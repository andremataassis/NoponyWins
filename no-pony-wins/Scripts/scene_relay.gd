extends Node

# just a relay to the singleton reference to add to local scenes
func to_game():
	SM.inst.load_scene(SM.Scene.Game)

func to_start():
	SM.inst.load_scene(SM.Scene.Start)
