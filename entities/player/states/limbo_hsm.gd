extends LimboHSM


@export var character : CharacterBody2D

@export var states : Dictionary[String, LimboState]

func _ready():
	_binding_setup()
	initialize(character)
	set_active(true)

func _binding_setup():
	add_transition(states["ground"], states["air"], "in_air")
	add_transition(states["ground"], states["air"], "jump")
	add_transition(states["ground"], states["crouch"], "crouching")
	add_transition(states["ground"], states["move"], "move")
	add_transition(states["air"], states["ground"], "on_ground")
	add_transition(states["crouch"], states["ground"], "to_stand")
	add_transition(states["move"], states["ground"], "stop")
	add_transition(states["move"], states["air"], "moving_jump")
	add_transition(states["move"], states["crouch"], "crouching")
