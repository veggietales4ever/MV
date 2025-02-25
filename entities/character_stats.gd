class_name CharacterStats
extends Resource

signal health_depleted()

@export var run_speed : float = 100.0 # := is the data type of first value is the only data type this var can accept.
@export var acceleration : float = 1200.0
@export var friction : float = 1800.0
@export var jump_velocity : float = 275


@export var health : int = 20:
	set(value):
		var old_value = health
		health = value
		
		if health < 0 && old_value > 0:
			health_depleted.emit()
