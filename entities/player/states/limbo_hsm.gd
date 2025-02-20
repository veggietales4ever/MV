extends LimboHSM


@export var character : CharacterBody2D

@export var states : Dictionary[String, LimboState]

func _ready():
	initialize(character)
	set_active(true)
	_binding_setup()

func _binding_setup():
	add_transition(states["idle"], states["move"], "moving")
	add_transition(states["move"], states["idle"], "stopped")
