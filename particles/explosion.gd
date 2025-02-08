extends Node2D

@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cpu_particles_2d.emitting = true
	await get_tree().create_timer(cpu_particles_2d.lifetime).timeout
	queue_free()

# Function to set explosion color based on enemy's color
func set_explosion_color(color: Color):
	cpu_particles_2d.modulate = color #Apply color to the explosion
