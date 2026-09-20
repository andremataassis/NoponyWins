class_name ParticleGroup extends Node

@export var lifespan : float = 1
@export var play_on_ready : bool = true

func _ready() -> void:
	play()

func play():
	# trigger each particle effect
	for child in get_children():
		if child is CPUParticles3D:
			child.emitting = true
	
	await get_tree().create_timer(lifespan).timeout
	# remove this particle effect
	queue_free()
