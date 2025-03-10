class_name CharacterStats
extends Resource

signal health_depleted

@export var run_speed := 100.0 # := is the data type of first value is the only data type this var can accept.
@export var acceleration := 1200
@export var friction := 1800
@export var jump_velocity : float = 275

@export var health : int = 100 :
	set(value):
		var old_value = health
		health = value
		
		if health <= 0 && old_value > 0:
			health_depleted.emit()

@export var max_health : int = 500
