extends LimboHSM


@export var character : Character

@export var states : Dictionary[String, LimboState]

func _ready():
	_binding_setup()
	initialize(character)
	set_active(true)
	character.stats.health_depleted.connect(_on_health_depleted)

func _binding_setup():
	add_transition(states["ground"], states["air"], "in_air")
	add_transition(states["air"], states["ground"], "on_ground")
	add_transition(states["air"], states["air_attack"], "attack")
	add_transition(states["ground"], states["air"], "jump")
	add_transition(states["ground"], states["crouch"], "crouching")
	add_transition(states["ground"], states["attack"], "attack")
	add_transition(states["crouch"], states["ground"], "to_stand")
	add_transition(states["attack"], states["ground"], "finished")
	add_transition(states["air_attack"], states["air"], "finished")
	add_transition(states["air_attack"], states["ground"], "on_ground")
	add_transition(states["ground"], states["hurt"], "hurt")
	add_transition(states["attack"], states["air"], "in_air")

func _on_health_depleted():
	change_active_state(states["dead"])
