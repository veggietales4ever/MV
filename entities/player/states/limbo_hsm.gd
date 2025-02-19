extends LimboHSM


@export var character : CharacterBody2D

@export var states : Array[Dictionary] = []

func _ready():
	initialize(character)
	set_active(true)

func _binding_setup():
	pass
	#add_transition(states["idle"], states["move"], "moving")
